
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `active_storage_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_storage_attachments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `record_type` varchar(255) NOT NULL,
  `record_id` bigint(20) NOT NULL,
  `blob_id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_attachments_uniqueness` (`record_type`,`record_id`,`name`,`blob_id`),
  KEY `index_active_storage_attachments_on_blob_id` (`blob_id`),
  CONSTRAINT `fk_rails_c3b3935057` FOREIGN KEY (`blob_id`) REFERENCES `active_storage_blobs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `active_storage_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_storage_blobs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `metadata` text DEFAULT NULL,
  `byte_size` bigint(20) NOT NULL,
  `checksum` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `service_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_blobs_on_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `active_storage_variant_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_storage_variant_records` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `blob_id` bigint(20) NOT NULL,
  `variation_digest` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_variant_records_uniqueness` (`blob_id`,`variation_digest`),
  CONSTRAINT `fk_rails_993965df05` FOREIGN KEY (`blob_id`) REFERENCES `active_storage_blobs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `cart_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_products` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `total_price` decimal(8,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `cart_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_cart_products_on_cart_id_and_product_id` (`cart_id`,`product_id`),
  KEY `index_cart_products_on_cart_id` (`cart_id`),
  KEY `index_cart_products_on_product_id` (`product_id`),
  CONSTRAINT `fk_rails_a4f3e327f3` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`),
  CONSTRAINT `fk_rails_b6ff2a078a` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `price_cart_product_check` CHECK (`total_price` > 0),
  CONSTRAINT `quantity_cart_product_check` CHECK (`quantity` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sub_total` decimal(8,2) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_carts_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_ea59a35211` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `price_cart_check` CHECK (`sub_total` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `command_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `command_products` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(8,2) NOT NULL,
  `unit_price` decimal(8,2) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `command_id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_command_products_on_product_id` (`product_id`),
  KEY `index_command_products_on_command_id` (`command_id`),
  CONSTRAINT `fk_rails_064b6c733b` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `fk_rails_0b28ae07bc` FOREIGN KEY (`command_id`) REFERENCES `commands` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `commands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commands` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sub_total` decimal(8,2) NOT NULL,
  `tps` decimal(8,2) NOT NULL,
  `tvq` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `store_pickup` tinyint(1) NOT NULL,
  `state` varchar(50) NOT NULL,
  `shipping_adress` varchar(159) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_commands_on_user_id` (`user_id`),
  FULLTEXT KEY `fulltext_command_shipping_adress` (`shipping_adress`),
  FULLTEXT KEY `fulltext_command_state` (`state`),
  CONSTRAINT `fk_rails_370b310a97` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` varchar(2500) NOT NULL,
  `status` varchar(10) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `admin_id` bigint(20) NOT NULL DEFAULT 1,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_conversations_on_user_id` (`user_id`),
  KEY `index_conversations_on_admin_id` (`admin_id`),
  FULLTEXT KEY `fulltext_conversations` (`title`,`description`),
  FULLTEXT KEY `fulltext_conversation_title` (`title`),
  FULLTEXT KEY `fulltext_conversation_status` (`status`),
  CONSTRAINT `fk_rails_7c15d62a0a` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_rails_8fc2a42834` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `current_taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `current_taxes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tps` decimal(8,2) NOT NULL,
  `tvq` decimal(8,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` varchar(2500) NOT NULL,
  `conversation_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_messages_on_conversation_id` (`conversation_id`),
  KEY `index_messages_on_user_id` (`user_id`),
  FULLTEXT KEY `fulltext_messages` (`body`),
  CONSTRAINT `fk_rails_273a25a7a6` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_rails_7f927086d2` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(2500) NOT NULL,
  `quantity` int(11) NOT NULL,
  `animal_type` varchar(50) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `fulltext_products` (`category`,`title`,`description`,`animal_type`),
  CONSTRAINT `price_product_check` CHECK (`price` > 0),
  CONSTRAINT `quantity_product_check` CHECK (`quantity` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `products_sommary`;
/*!50001 DROP VIEW IF EXISTS `products_sommary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `products_sommary` (
  `products_title` tinyint NOT NULL,
  `products_category` tinyint NOT NULL,
  `products_animal_type` tinyint NOT NULL,
  `products_price` tinyint NOT NULL,
  `sum_of_cart_products_quantity` tinyint NOT NULL,
  `average_cart_products_quantity` tinyint NOT NULL,
  `sum_of_cart_products_total` tinyint NOT NULL,
  `average_cart_products_total` tinyint NOT NULL,
  `products_number_of_cart` tinyint NOT NULL,
  `average_carts_total` tinyint NOT NULL,
  `created_at` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `user_commands_summary`;
/*!50001 DROP VIEW IF EXISTS `user_commands_summary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `user_commands_summary` (
  `email` tinyint NOT NULL,
  `fullname` tinyint NOT NULL,
  `unit_product_value_average` tinyint NOT NULL,
  `average_unit_per_product` tinyint NOT NULL,
  `minimum_command_value_sub_total` tinyint NOT NULL,
  `Average_command_value_sub_total` tinyint NOT NULL,
  `maximum_command_value_sub_total` tinyint NOT NULL,
  `total_command_value` tinyint NOT NULL,
  `last_command` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `user_conversation_messages_summary`;
/*!50001 DROP VIEW IF EXISTS `user_conversation_messages_summary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `user_conversation_messages_summary` (
  `email` tinyint NOT NULL,
  `fullname` tinyint NOT NULL,
  `title` tinyint NOT NULL,
  `number_messages` tinyint NOT NULL,
  `length_messages` tinyint NOT NULL,
  `avg_length_messages` tinyint NOT NULL,
  `conversation_created_at` tinyint NOT NULL,
  `number_days_resolution` tinyint NOT NULL,
  `status` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `fullname` varchar(101) GENERATED ALWAYS AS (concat(`firstname`,' ',`lastname`)) VIRTUAL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `postal_code` varchar(6) NOT NULL,
  `province` varchar(50) NOT NULL,
  `phone_number` varchar(10) NOT NULL,
  `picture_name` varchar(100) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  FULLTEXT KEY `fulltext_users` (`email`,`firstname`,`lastname`,`address`,`city`,`postal_code`,`province`,`phone_number`,`picture_name`),
  FULLTEXT KEY `fulltext_users_fullname` (`firstname`,`lastname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50001 DROP TABLE IF EXISTS `products_sommary`*/;
/*!50001 DROP VIEW IF EXISTS `products_sommary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `products_sommary` AS select `p`.`title` AS `products_title`,`p`.`category` AS `products_category`,`p`.`animal_type` AS `products_animal_type`,`p`.`price` AS `products_price`,sum(`cp`.`quantity`) AS `sum_of_cart_products_quantity`,format(avg(`cp`.`quantity`),0,'fr_FR') AS `average_cart_products_quantity`,sum(`cp`.`total_price`) AS `sum_of_cart_products_total`,format(avg(`cp`.`total_price`),2,'fr_FR') AS `average_cart_products_total`,count(`cp`.`cart_id`) AS `products_number_of_cart`,format(avg(`c`.`sub_total`),2,'fr_FR') AS `average_carts_total`,date_format(`cp`.`created_at`,'%m/%d/%Y') AS `created_at` from ((`products` `p` join `cart_products` `cp` on(`p`.`id` = `cp`.`product_id`)) join `carts` `c` on(`c`.`id` = `cp`.`cart_id`)) group by `p`.`title` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `user_commands_summary`*/;
/*!50001 DROP VIEW IF EXISTS `user_commands_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_commands_summary` AS select `users`.`email` AS `email`,concat(`users`.`firstname`,' ',`users`.`lastname`) AS `fullname`,format(avg(`command_products`.`unit_price`),2,'fr_FR') AS `unit_product_value_average`,count(`command_products`.`quantity`) AS `average_unit_per_product`,format(min(`commands`.`sub_total`),2,'fr_FR') AS `minimum_command_value_sub_total`,format(avg(`commands`.`sub_total`),2,'fr_FR') AS `Average_command_value_sub_total`,format(max(`commands`.`sub_total`),2,'fr_FR') AS `maximum_command_value_sub_total`,format(sum(`commands`.`total`),2,'fr_FR') AS `total_command_value`,max(date_format(`commands`.`created_at`,'%m/%d/%Y')) AS `last_command` from ((`users` join `commands` on(`commands`.`user_id` = `users`.`id`)) join `command_products` on(`command_products`.`command_id` = `commands`.`id`)) group by `users`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `user_conversation_messages_summary`*/;
/*!50001 DROP VIEW IF EXISTS `user_conversation_messages_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_conversation_messages_summary` AS select `u`.`email` AS `email`,concat(`u`.`firstname`,' ',`u`.`lastname`) AS `fullname`,`c`.`title` AS `title`,count(`m`.`body`) AS `number_messages`,sum(octet_length(`m`.`body`)) AS `length_messages`,format(avg(octet_length(`m`.`body`)),0) AS `avg_length_messages`,date_format(`c`.`created_at`,'%y/%m/%d') AS `conversation_created_at`,to_days(date_format(`c`.`updated_at`,'%y/%m/%d')) - to_days(date_format(`c`.`created_at`,'%y/%m/%d')) AS `number_days_resolution`,`c`.`status` AS `status` from ((`users` `u` join `conversations` `c` on(`c`.`user_id` = `u`.`id`)) join `messages` `m` on(`m`.`conversation_id` = `c`.`id`)) group by `u`.`fullname` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO `schema_migrations` (version) VALUES
('20210208180557'),
('20210212204356'),
('20210215140542'),
('20210215195512'),
('20210221000405'),
('20210221000409'),
('20210223143356'),
('20210223144657'),
('20210223162502'),
('20210223162503'),
('20210224061352'),
('20210225160131'),
('20210303162622'),
('20210304171549'),
('20210310234550');


