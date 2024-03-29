import { Pressable, RefreshControl, StyleSheet, View } from "react-native";
import { ThemedText } from "~/components/ThemedComponents";
import { useRoute } from "@react-navigation/native";
import { useQuery } from "@tanstack/react-query";
import { EventData, MarketPlaceCardProps } from "~/types/Events";
import {
  getUserProfileEvents,
  getUserProfilePosts,
} from "~/lib/apiFunctions/Profile";
import useLoadingContext from "~/hooks/useLoadingContext";
import useRefreshControl from "~/hooks/useRefreshControl";
import { useCallback, useEffect } from "react";
import { FlashList } from "@shopify/flash-list";
import HorizontalScrollElement from "~/components/HorizontalScrollElement";
import MarketplaceItem from "~/components/MarketplaceItem";
import { generateImageURL } from "~/lib/CDNFunctions";
import LookingForItem from "~/components/SearchLookingForBar";
import { PostType } from "~/types/LookingFor";

export default function ProfilePosts() {
  const {
    params: { id },
  } = useRoute<any>();

  const {
    data: userProfilePosts,
    isLoading,
    refetch,
    isFetchedAfterMount,
    isFetching,
  } = useQuery<PostType[]>({
    queryKey: ["user-posts", id],
    queryFn: () => getUserProfilePosts(id),
    initialData: [],
  });

  const { startLoading, stopLoading } = useLoadingContext();

  const { refreshing, triggerRefresh, stopRefresh } = useRefreshControl();

  const onPullRefresh = useCallback(() => {
    triggerRefresh(() => {
      refetch();
    });
  }, []);

  useEffect(() => {
    if (isLoading) startLoading();
    else stopLoading();
  }, [isLoading]);

  const queryIsLoading = isFetching && isFetchedAfterMount;
  useEffect(() => {
    if (!queryIsLoading) stopRefresh();
  }, [queryIsLoading]);

  console.log(userProfilePosts);

  return (
    <View style={{ flex: 1 }}>
      <FlashList
        data={userProfilePosts}
        showsVerticalScrollIndicator={false}
        renderItem={({ item }) => (
          <Pressable>
            <View style={{ paddingHorizontal: 20 }}>
              <LookingForItem
                key={item.id}
                title={item.title}
                description={item.description}
                requiredMembers={item.spotsLeft}
              />
            </View>
          </Pressable>
        )}
        keyExtractor={(item) => item.id}
        contentContainerStyle={{ paddingTop: 20 }}
        estimatedItemSize={20}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={onPullRefresh} />
        }
        extraData={queryIsLoading}
        ListHeaderComponent={() => (
          <ThemedText
            style={{
              paddingLeft: 20,
              fontFamily: "Nunito-Bold",
              fontSize: 24,
            }}
          >
            Your Posts
          </ThemedText>
        )}
        ListEmptyComponent={() => (
          <View
            style={{
              flex: 1,
              justifyContent: "center",
              alignItems: "center",
            }}
          >
            <ThemedText style={{ textAlign: "center", marginTop: 150 }}>
              Create a post to see it here!
            </ThemedText>
          </View>
        )}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  itemsContainer: {
    flexDirection: "row",
    justifyContent: "center",
    flexWrap: "wrap",
    paddingHorizontal: 20,
  },
});
