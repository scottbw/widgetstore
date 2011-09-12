#INSERT INTO `widgetdb`.`widget` (`id`, `jpa_version`, `height`, `width`, `guid`, `widget_author`, `widget_author_email`, `widget_author_href`, `widget_version`) VALUES (0, 1, 100, 100, 'http://dummy', 'd', 'd', 'd', '1.0');

INSERT INTO `storeusers` (`id`, `fullname`, `username`, `password`, `salt`, `email`, `hashedUserNameWS`) VALUES
(0, 'demo',         'demo',     'MgzIKfCV2g4VC/Bw3UvfVfZ6ze0=', 'DABF8B8F-6203-56AF-815C-4BCA0668F875', 'demo@demo.com',    'MgzIKfCV2g4VC/Bw3UvfVfZ6ze0='),
(1, 'Test User 1',  'test1', '9WTTukClYQfkPel0Q6V0ViBTD5I=',    '691096F6-38D1-CBFC-9431-CA534D4823A5', 'test1',            'E+n9/dtQtfF7QOoZNSXIZOTV7zE='),
(2, 'Test User 2',  'test2', 'HIlm9DHhwwDbNvUHFiqXOOjeT3I=',    '28A76F82-92D7-4BB6-4032-7DE5FF8D5652', 'test2',            'H7RtrlsiAk7LVontIJgHBw/iqXY='),
(3, 'Test User 3',  'test3', 'CZUB11+az9XWTO/EvUsR7bWnJkI=',    'FBF1B8A7-560C-ACB9-8F51-F0687219178A', 'test3',            'cNKKSDQdM86e+2EBf1Zv0MbVBxM=');

INSERT INTO `tags` (id,tagtext) VALUES (1,'java');
INSERT INTO `tags` (id,tagtext) VALUES (2,'javascript');
INSERT INTO `tags` (id,tagtext) VALUES (3,'agile');
INSERT INTO `tags` (id,tagtext) VALUES (4,'development');
INSERT INTO `tags` (id,tagtext) VALUES (5,'design');
INSERT INTO `tags` (id,tagtext) VALUES (6,'game');
INSERT INTO `tags` (id,tagtext) VALUES (7,'education');
INSERT INTO `tags` (id,tagtext) VALUES (8,'learning');
INSERT INTO `tags` (id,tagtext) VALUES (9,'mashup');
INSERT INTO `tags` (id,tagtext) VALUES (10,'academic');
INSERT INTO `tags` (id,tagtext) VALUES (11,'programming');
INSERT INTO `tags` (id,tagtext) VALUES (12,'beer');
INSERT INTO `tags` (id,tagtext) VALUES (13,'coffee');

INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (1,1,1);
INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (2,2,1);
INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (3,3,1);
INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (4,4,1);
INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (5,2,1);
INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (6,4,2);
INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (7,6,2);
INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (8,9,2);
#INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (9,11,2);
#INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (10,12,2);
INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (11,5,3);
INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (12,7,3);
INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (13,8,3);
#INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (14,10,3);
#INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (15,13,3);
#INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (16,12,3);
#INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (17,12,4);
#INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (18,12,5);
#INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (19,12,6);
#INSERT INTO `tagswidgets` (id,tagid,widid) VALUES (20,12,7);

INSERT INTO `comments` (id,widid,userid,commentext,creationDate) VALUES (1,1,1,'Unsupported widget comment by user 1','2011-03-30 17:27:44');
INSERT INTO `comments` (id,widid,userid,commentext,creationDate) VALUES (2,1,2,'A comment by user 2','2011-03-30 17:28:38');
INSERT INTO `comments` (id,widid,userid,commentext,creationDate) VALUES (3,2,2,'Dependency enabled, comment by user 2','2011-03-30 17:28:59');
INSERT INTO `comments` (id,widid,userid,commentext,creationDate) VALUES (4,3,2,'you descide widget, comment by user 2','2011-03-30 17:29:21');
INSERT INTO `comments` (id,widid,userid,commentext,creationDate) VALUES (5,2,1,'A comment by user 1 for this widget','2011-03-30 17:29:39');
INSERT INTO `comments` (id,widid,userid,commentext,creationDate) VALUES (6,3,1,'This is a cool widget !!! by user 1','2011-03-30 17:29:57');

INSERT INTO `apikey` (id,jpa_version,value,email,userID) VALUES (1,1,'DEVELOPMENT_TEST_API_KEY','test@test.com',1);
INSERT INTO `apikey` (id,jpa_version,value,email,userID) VALUES (2,1,'DEVELOPMENT_TEST_API_KEY2','test2@test.com',1);
INSERT INTO `apikey` (id,jpa_version,value,email,userID) VALUES (3,1,'DEVELOPMENT_TEST_API_KEY3','test3@test.com',1);
INSERT INTO `apikey` (id,jpa_version,value,email,userID) VALUES (4,1,'DEVELOPMENT_TEST_API_KEY4','test4@test.com',2);
INSERT INTO `apikey` (id,jpa_version,value,email,userID) VALUES (5,1,'DEVELOPMENT_TEST_API_KEY5','test5@test.com',2);
INSERT INTO `apikey` (id,jpa_version,value,email,userID) VALUES (6,1,'DEVELOPMENT_TEST_API_KEY6','test6@test.com',3);
INSERT INTO `apikey` (id,jpa_version,value,email,userID) VALUES (7,1,'DEVELOPMENT_TEST_API_KEY7','test7@test.com',3);

INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (1,1,0);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (2,2,1);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (3,2,2);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (4,2,3);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (5,3,1);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (6,3,2);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (7,3,3);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (8,3,4);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (9,3,5);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (10,3,6);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (11,3,7);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (12,4,0);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (13,5,1);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (14,5,2);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (15,6,3);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (16,6,4);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (17,6,5);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (18,7,1);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (19,7,3);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (20,7,4);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (21,7,5);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (22,7,6);
INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (23,7,7);

INSERT INTO `apikeywidgets` (id,ApiKey,widgetId) VALUES (24,401,0);

INSERT INTO `rating` (id,userid,widid,rate) VALUES (1,1,1,5);
INSERT INTO `rating` (id,userid,widid,rate) VALUES (2,1,2,6);
INSERT INTO `rating` (id,userid,widid,rate) VALUES (3,1,3,6.5);
INSERT INTO `rating` (id,userid,widid,rate) VALUES (4,2,1,7);
INSERT INTO `rating` (id,userid,widid,rate) VALUES (5,2,3,7.5);
INSERT INTO `rating` (id,userid,widid,rate) VALUES (6,2,4,8);
INSERT INTO `rating` (id,userid,widid,rate) VALUES (7,3,1,8.5);
INSERT INTO `rating` (id,userid,widid,rate) VALUES (8,3,2,9);
INSERT INTO `rating` (id,userid,widid,rate) VALUES (9,3,3,5.5);
INSERT INTO `rating` (id,userid,widid,rate) VALUES (10,3,4,9.5);
