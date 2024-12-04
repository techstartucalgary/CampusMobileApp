-- CreateTable
CREATE TABLE `institution` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `domain` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `locationPlaceId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `institution_name_key`(`name`),
    UNIQUE INDEX `institution_domain_key`(`domain`),
    INDEX `institution_locationPlaceId_idx`(`locationPlaceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user` (
    `id` VARCHAR(191) NOT NULL,
    `first_name` VARCHAR(191) NOT NULL,
    `last_name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `profile_pic` VARCHAR(191) NULL,
    `institution_id` VARCHAR(191) NULL,
    `account_type` ENUM('Student', 'PendingOrg', 'ApprovedOrg', 'Admin') NOT NULL,
    `degree_name` VARCHAR(191) NULL,
    `otp` VARCHAR(191) NULL,
    `otpExpiry` DATETIME(3) NULL,
    `signed_in` BOOLEAN NOT NULL DEFAULT false,

    UNIQUE INDEX `user_id_key`(`id`),
    UNIQUE INDEX `user_email_key`(`email`),
    UNIQUE INDEX `user_profile_pic_key`(`profile_pic`),
    INDEX `user_email_idx`(`email`),
    INDEX `user_institution_id_idx`(`institution_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `enrollment` (
    `program_id` VARCHAR(191) NOT NULL,
    `user_id` VARCHAR(191) NOT NULL,
    `degree_type` VARCHAR(191) NOT NULL,
    `year_of_study` INTEGER NOT NULL,

    INDEX `enrollment_program_id_idx`(`program_id`),
    INDEX `enrollment_user_id_idx`(`user_id`),
    PRIMARY KEY (`program_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `program` (
    `id` VARCHAR(191) NOT NULL,
    `programName` VARCHAR(191) NOT NULL,
    `department` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event` (
    `id` VARCHAR(191) NOT NULL,
    `user_id` VARCHAR(191) NOT NULL,
    `organization_id` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `title` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255) NULL,
    `start_time` DATETIME(3) NOT NULL,
    `end_time` DATETIME(3) NOT NULL,
    `is_public` BOOLEAN NOT NULL DEFAULT true,
    `isFlagged` BOOLEAN NOT NULL DEFAULT false,
    `status` ENUM('Verified', 'NonVerified') NOT NULL,
    `image` VARCHAR(191) NULL,
    `locationPlaceId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `event_created_at_key`(`created_at`),
    INDEX `event_user_id_idx`(`user_id`),
    INDEX `event_organization_id_idx`(`organization_id`),
    INDEX `event_locationPlaceId_idx`(`locationPlaceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_event_response` (
    `user_id` VARCHAR(191) NOT NULL,
    `event_id` VARCHAR(191) NOT NULL,
    `participation_status` ENUM('Interested', 'Going') NOT NULL,

    INDEX `user_event_response_user_id_idx`(`user_id`),
    INDEX `user_event_response_event_id_idx`(`event_id`),
    PRIMARY KEY (`user_id`, `event_id`, `participation_status`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `post` (
    `id` VARCHAR(191) NOT NULL,
    `user_id` VARCHAR(191) NOT NULL,
    `organization_id` VARCHAR(191) NULL,
    `image` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `title` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `isPublic` BOOLEAN NOT NULL DEFAULT true,
    `isFlagged` BOOLEAN NOT NULL DEFAULT false,
    `expires_at` DATETIME(3) NULL,
    `number_of_spots` INTEGER NULL,
    `number_of_spots_left` INTEGER NULL,
    `type` ENUM('LookingFor', 'Thread') NOT NULL,
    `institution_id` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `post_created_at_key`(`created_at`),
    INDEX `post_user_id_idx`(`user_id`),
    INDEX `post_organization_id_idx`(`organization_id`),
    INDEX `post_institution_id_idx`(`institution_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `comment` (
    `id` VARCHAR(191) NOT NULL,
    `user_id` VARCHAR(191) NOT NULL,
    `post_id` VARCHAR(191) NOT NULL,
    `content` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `comment_created_at_key`(`created_at`),
    INDEX `comment_user_id_idx`(`user_id`),
    INDEX `comment_post_id_idx`(`post_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `post_attendance` (
    `post_id` VARCHAR(191) NOT NULL,
    `user_id` VARCHAR(191) NOT NULL,

    INDEX `post_attendance_user_id_idx`(`user_id`),
    INDEX `post_attendance_post_id_idx`(`post_id`),
    PRIMARY KEY (`post_id`, `user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `organization` (
    `id` VARCHAR(191) NOT NULL,
    `organization_name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,
    `status` ENUM('Pending', 'Approved', 'Rejected') NOT NULL DEFAULT 'Pending',
    `image` VARCHAR(191) NULL,
    `institution_id` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `organization_organization_name_key`(`organization_name`),
    UNIQUE INDEX `organization_created_at_key`(`created_at`),
    INDEX `organization_institution_id_idx`(`institution_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_organization_role` (
    `user_id` VARCHAR(191) NOT NULL,
    `organization_id` VARCHAR(191) NOT NULL,
    `role_id` VARCHAR(191) NOT NULL,
    `status` ENUM('Pending', 'Approved', 'Rejected', 'Banned') NOT NULL,

    INDEX `user_organization_role_user_id_idx`(`user_id`),
    INDEX `user_organization_role_organization_id_idx`(`organization_id`),
    INDEX `user_organization_role_role_id_idx`(`role_id`),
    PRIMARY KEY (`user_id`, `organization_id`, `role_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `role` (
    `id` VARCHAR(191) NOT NULL,
    `role_name` ENUM('Owner', 'Admin', 'Moderator', 'Member') NOT NULL,

    UNIQUE INDEX `role_role_name_key`(`role_name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `organization_role_permission` (
    `organization_id` VARCHAR(191) NOT NULL,
    `role_id` VARCHAR(191) NOT NULL,
    `permission_id` VARCHAR(191) NOT NULL,

    INDEX `organization_role_permission_organization_id_idx`(`organization_id`),
    INDEX `organization_role_permission_role_id_idx`(`role_id`),
    INDEX `organization_role_permission_permission_id_idx`(`permission_id`),
    PRIMARY KEY (`organization_id`, `role_id`, `permission_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `permission` (
    `id` VARCHAR(191) NOT NULL,
    `permission_name` ENUM('CREATE_EVENTS', 'MANAGE_EVENTS', 'CREATE_POSTS', 'MANAGE_POSTS', 'MANAGE_MEMBERS', 'APPROVE_MEMBER_REQUESTS', 'VIEW_ANALYTICS', 'MANAGE_ORGANIZATION', 'DELETE_ORGANIZATION') NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `topic` (
    `id` VARCHAR(191) NOT NULL,
    `topic_name` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `topic_topic_name_key`(`topic_name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `event_tag` (
    `event_id` VARCHAR(191) NOT NULL,
    `topic_id` VARCHAR(191) NOT NULL,

    INDEX `event_tag_event_id_idx`(`event_id`),
    INDEX `event_tag_topic_id_idx`(`topic_id`),
    PRIMARY KEY (`event_id`, `topic_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `post_tag` (
    `post_id` VARCHAR(191) NOT NULL,
    `topic_id` VARCHAR(191) NOT NULL,

    INDEX `post_tag_post_id_idx`(`post_id`),
    INDEX `post_tag_topic_id_idx`(`topic_id`),
    PRIMARY KEY (`post_id`, `topic_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `topic_subscription` (
    `user_id` VARCHAR(191) NOT NULL,
    `topic_id` VARCHAR(191) NOT NULL,

    INDEX `topic_subscription_user_id_idx`(`user_id`),
    INDEX `topic_subscription_topic_id_idx`(`topic_id`),
    PRIMARY KEY (`user_id`, `topic_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `location` (
    `placeId` VARCHAR(191) NOT NULL,
    `latitude` DOUBLE NOT NULL,
    `longitude` DOUBLE NOT NULL,
    `name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`placeId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item` (
    `id` VARCHAR(191) NOT NULL,
    `user_id` VARCHAR(191) NOT NULL,
    `institution_id` VARCHAR(191) NOT NULL,
    `isPublic` BOOLEAN NOT NULL DEFAULT true,
    `isFlagged` BOOLEAN NOT NULL DEFAULT false,
    `title` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `price` INTEGER NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `condition` VARCHAR(191) NULL,
    `locationPlaceId` VARCHAR(191) NOT NULL,
    `state` ENUM('Available', 'Sold', 'Removed') NOT NULL,

    UNIQUE INDEX `item_created_at_key`(`created_at`),
    INDEX `item_user_id_idx`(`user_id`),
    INDEX `item_institution_id_idx`(`institution_id`),
    INDEX `item_locationPlaceId_idx`(`locationPlaceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `image` (
    `id` VARCHAR(191) NOT NULL,
    `item_id` VARCHAR(191) NOT NULL,
    `url` VARCHAR(191) NOT NULL,

    INDEX `image_item_id_idx`(`item_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `push_token` (
    `user_id` VARCHAR(191) NOT NULL,
    `push_token` VARCHAR(191) NOT NULL,

    INDEX `push_token_user_id_idx`(`user_id`),
    UNIQUE INDEX `push_token_user_id_push_token_key`(`user_id`, `push_token`),
    PRIMARY KEY (`user_id`, `push_token`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
