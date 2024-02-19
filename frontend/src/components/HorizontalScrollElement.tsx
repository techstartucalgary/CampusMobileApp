import { FlatList, Text, View } from "react-native";
import React from "react";
import { Item } from "~/components/VerticalScrollView";
import EventHomeCard from "./HomeEventCard";

type Item2 = {
  title: string;
  items: Item[];
  id: string;
};

const HorizontalScrollElement = ({ item }: { item: Item2 }) => {
  return (
    <View
      style={{
        height: 214,
        margin: 14,
      }}
    >
      <Text
        style={{
          color: "white",
          fontSize: 15,
        }}
      >
        {item.title}
      </Text>
      <FlatList
        style={{ backgroundColor: "red", marginBottom: 0, height:130 }}
        data={item.items}
        renderItem={Cards}
        horizontal={true}
        showsHorizontalScrollIndicator={false}
      />
    </View>
  );
};

const Cards = ({ item }: { item: Item }) => {
  return (
    <View>
      <Text
        style={{
          color: "white",
          fontSize: 15,
          paddingRight: 100,
        }}
      >
        <EventHomeCard eventData={item} />
      </Text>
    </View>
  );
};
export default HorizontalScrollElement;
