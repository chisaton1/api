CREATE SCHEMA IF NOT EXISTS `instagram` DEFAULT CHARACTER SET utf8 ;
USE `instagram` ;

-- -----------------------------------------------------
-- Table `instagram`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instagram`.`users` (
  `uid` VARCHAR(32) NOT NULL,
  `username` VARCHAR(64) NOT NULL,
  `description` VARCHAR(256) NULL,
  `website_url` VARCHAR(128) NULL,
  `icon_url` VARCHAR(128) NULL,
  PRIMARY KEY (`uid`),
  UNIQUE INDEX `username_unique` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instagram`.`follow_relationships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instagram`.`follow_relationships` (
  `followed_by` VARCHAR(32) NOT NULL,
  `follow_to` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`followed_by`, `follow_to`),
  INDEX `fk_follow_to_idx` (`follow_to` ASC),
  INDEX `fk_followed_by_idx` (`followed_by` ASC),
  CONSTRAINT `fk_users_has_users_users`
    FOREIGN KEY (`followed_by`)
    REFERENCES `instagram`.`users` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_users_users1`
    FOREIGN KEY (`follow_to`)
    REFERENCES `instagram`.`users` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instagram`.`posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instagram`.`posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_uid` VARCHAR(32) NOT NULL,
  `comment` VARCHAR(256) NOT NULL,
  `filename` VARCHAR(64) NOT NULL,
  `is_image` TINYINT NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_posts_users_idx` (`user_uid` ASC),
  CONSTRAINT `fk_posts_users`
    FOREIGN KEY (`user_uid`)
    REFERENCES `instagram`.`users` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instagram`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instagram`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `post_id` INT NOT NULL,
  `content` VARCHAR(256) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_uid` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_posts_idx` (`post_id` ASC),
  INDEX `fk_comments_users_idx` (`user_uid` ASC),
  CONSTRAINT `fk_comments_posts`
    FOREIGN KEY (`post_id`)
    REFERENCES `instagram`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_users`
    FOREIGN KEY (`user_uid`)
    REFERENCES `instagram`.`users` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instagram`.`favorites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instagram`.`favorites` (
  `favorited_by` VARCHAR(32) NOT NULL,
  `post_id` INT NOT NULL,
  INDEX `fk_favorites_posts_idx` (`post_id` ASC),
  INDEX `fk_favorites_users_idx` (`favorited_by` ASC),
  PRIMARY KEY (`favorited_by`, `post_id`),
  CONSTRAINT `fk_favourites_posts1`
    FOREIGN KEY (`post_id`)
    REFERENCES `instagram`.`posts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favourites_users1`
    FOREIGN KEY (`favorited_by`)
    REFERENCES `instagram`.`users` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
