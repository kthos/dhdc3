/*
Navicat MySQL Data Transfer

Source Server         : localhost3309
Source Server Version : 50548
Source Host           : localhost:3309
Source Database       : dhdc3

Target Server Type    : MYSQL
Target Server Version : 50548
File Encoding         : 65001

Date: 2017-08-07 14:18:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dhdc_adhoc
-- ----------------------------
DROP TABLE IF EXISTS `dhdc_adhoc`;
CREATE TABLE `dhdc_adhoc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `sql_sum` longtext,
  `desc_sum` varchar(255) DEFAULT NULL,
  `sql_indiv` longtext,
  `desc_indiv` varchar(255) DEFAULT NULL,
  `date_begin` date DEFAULT NULL,
  `date_end` date DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `note1` varchar(255) DEFAULT NULL,
  `note2` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dhdc_adhoc
-- ----------------------------
INSERT INTO `dhdc_adhoc` VALUES ('1', '1.1 รอยละของประชากรไทยอายุ 35-74 ป ไดรับการคัดกรองเบาหวาน โดยการตรวจวัดระดับน้ําตาลในเลือด', 'SELECT h.hoscode,h.hosname,tt.B,tt.A,ROUND(tt.A*100/tt.B,2) RATE FROM  (\r\nSELECT  t.HOSPCODE,COUNT(t.HOSPCODE) B , COUNT(if(t.`CHECK` is NULL ,NULL,t.HOSPCODE)) A from\r\n(\r\nSELECT p.HOSPCODE,p.PID,p.CID,concat(p.`NAME`,\' \',p.LNAME) NAME,p.SEX,p.age_y AGE,p.TYPEAREA \r\n,GROUP_CONCAT(a.BSLEVEL) BSLEVEL\r\n,GROUP_CONCAT(a.DATE_SERV) DATE_SERV\r\n,if(GROUP_CONCAT(a.BSLEVEL) is not NULL,\'Y\',NULL) \'CHECK\'\r\nFROM t_person_cid p\r\nLEFT JOIN t_ncdscreen a ON p.CID = a.CID AND a.DATE_SERV BETWEEN \'2017-04-01\' AND \'2018-03-31\'\r\nWHERE p.age_y BETWEEN 35 AND 74 AND  p.TYPEAREA IN (1,3)\r\nGROUP BY p.CID\r\n)  t  GROUP BY t.HOSPCODE\r\n) tt RIGHT JOIN chospital_amp h ON h.hoscode = tt.HOSPCODE', 'B=ประชากรไทยอายุ 35-74 ป , A=ได้รับการคัดกรอง', 'SELECT p.HOSPCODE,p.PID,p.CID,concat(p.`NAME`,\' \',p.LNAME) NAME,p.SEX,p.age_y AGE,p.TYPEAREA \r\n,GROUP_CONCAT(a.BSLEVEL) BSLEVEL\r\n,GROUP_CONCAT(a.DATE_SERV) DATE_SERV\r\n,if(GROUP_CONCAT(a.BSLEVEL) is not NULL,\'Y\',NULL) \'CHECK\'\r\nFROM t_person_cid p\r\nLEFT JOIN t_ncdscreen a ON p.CID = a.CID AND a.DATE_SERV BETWEEN \'2017-04-01\' AND \'2018-03-31\'\r\nWHERE p.age_y BETWEEN 35 AND 74 AND  p.TYPEAREA IN (1,3)\r\nGROUP BY p.CID\r\n', 'Y=ผลงาน', null, null, 'qof2561', null, null, '2017-08-01 11:55:19', '1', '2017-08-07 13:44:13', '1');
INSERT INTO `dhdc_adhoc` VALUES ('2', '1.2 รอยละของประชากรไทยอายุ 35-74 ป ที่ไดรับการคัดกรองและวินิจฉัยเปน เบาหวาน', 'SELECT h.hoscode,h.hosname,tt.B,tt.A,ROUND(tt.A*100/tt.B,2) RATE FROM (\r\nSELECT t.HOSPCODE,COUNT(t.HOSPCODE) B , COUNT(if(t.`CHECK` is NULL ,NULL,t.HOSPCODE)) A from\r\n(\r\nSELECT p.*,a.min_date_dx_dm DATE_DX_DM\r\n,if(a.min_date_dx_dm is null,NULL,\'Y\') \'CHECK\'\r\n from (\r\nSELECT p.HOSPCODE,p.PID,p.CID,concat(p.`NAME`,\' \',p.LNAME) NAME,p.SEX,p.age_y AGE,p.TYPEAREA \r\n,GROUP_CONCAT(a.BSLEVEL) BSLEVEL\r\n,GROUP_CONCAT(a.DATE_SERV) DATE_SCREEN\r\nFROM t_person_cid p\r\nINNER JOIN t_ncdscreen a ON p.CID = a.CID AND a.DATE_SERV BETWEEN \'2017-04-01\' AND \'2018-03-31\' AND a.BSLEVEL is not NULL\r\nWHERE p.age_y BETWEEN 35 AND 74 AND p.TYPEAREA IN (1,3)\r\nGROUP BY p.CID \r\n) p  LEFT JOIN t_dmht  a ON p.CID = a.cid AND a.min_date_dx_dm BETWEEN  \'2017-04-01\' AND \'2018-03-31\'\r\n\r\n) t GROUP BY t.HOSPCODE\r\n) tt RIGHT JOIN chospital_amp h ON h.hoscode = tt.HOSPCODE', 'B=ประชากรไทยอายุ 35-74 ป ที่ไดรับการคัดกรอง , A=วินิจฉัยเปน เบาหวาน', 'SELECT p.*,a.min_date_dx_dm DATE_DX_DM\r\n,if(a.min_date_dx_dm is null,NULL,\'Y\') \'CHECK\'\r\n from (\r\nSELECT p.HOSPCODE,p.PID,p.CID,concat(p.`NAME`,\' \',p.LNAME) NAME,p.SEX,p.age_y AGE,p.TYPEAREA \r\n,GROUP_CONCAT(a.BSLEVEL) BSLEVEL\r\n,GROUP_CONCAT(a.DATE_SERV) DATE_SCREEN\r\nFROM t_person_cid p\r\nINNER JOIN t_ncdscreen a ON p.CID = a.CID AND a.DATE_SERV BETWEEN \'2017-04-01\' AND \'2018-03-31\' AND a.BSLEVEL is not NULL\r\nWHERE p.age_y BETWEEN 35 AND 74 AND p.TYPEAREA IN (1,3)\r\nGROUP BY p.CID \r\n) p  LEFT JOIN t_dmht  a ON p.CID = a.cid AND a.min_date_dx_dm BETWEEN \'2017-04-01\' AND \'2018-03-31\'', 'Y=ผลงาน', null, null, 'qof2561', null, null, '2017-08-03 11:24:31', '1', '2017-08-07 13:45:02', '1');
INSERT INTO `dhdc_adhoc` VALUES ('3', '2.1 รอยละของประชากรไทยอายุ 35-74ป ไดรับการคัดกรองความดันโลหิตสูง', 'SELECT h.hoscode,h.hosname,tt.B,tt.A,ROUND(tt.A*100/tt.B,2) RATE FROM (\r\nSELECT t.HOSPCODE,COUNT(t.HOSPCODE) B , COUNT(if(t.`CHECK` is NULL ,NULL,t.HOSPCODE)) A from\r\n(\r\nSELECT p.HOSPCODE,p.PID,p.CID,concat(p.`NAME`,\' \',p.LNAME) NAME,p.SEX,p.age_y AGE,p.TYPEAREA \r\n,GROUP_CONCAT(concat(a.SBP_1,\'/\',a.DBP_1)) BP\r\n,GROUP_CONCAT(a.DATE_SERV) DATE_SERV\r\n,if(GROUP_CONCAT(concat(a.SBP_1,\'/\',a.DBP_1)) is not NULL,\'Y\',NULL) \'CHECK\'\r\nFROM t_person_cid p\r\nLEFT JOIN t_ncdscreen a ON p.CID = a.CID AND a.DATE_SERV BETWEEN \'2017-04-01\' AND \'2018-03-31\'\r\nWHERE p.age_y BETWEEN 35 AND 74 AND p.TYPEAREA IN (1,3)\r\nGROUP BY p.CID\r\n) t GROUP BY t.HOSPCODE\r\n) tt RIGHT JOIN chospital_amp h ON h.hoscode = tt.HOSPCODE', 'B=ประชากรไทยอายุ 35-74 ป , A=ได้รับการคัดกรอง', 'SELECT p.HOSPCODE,p.PID,p.CID,concat(p.`NAME`,\' \',p.LNAME) NAME,p.SEX,p.age_y AGE,p.TYPEAREA \r\n,GROUP_CONCAT(concat(a.SBP_1,\'/\',a.DBP_1)) BP\r\n,GROUP_CONCAT(a.DATE_SERV) DATE_SERV\r\n,if(GROUP_CONCAT(concat(a.SBP_1,\'/\',a.DBP_1)) is not NULL,\'Y\',NULL) \'CHECK\'\r\nFROM t_person_cid p\r\nLEFT JOIN t_ncdscreen a ON p.CID = a.CID AND a.DATE_SERV BETWEEN \'2017-04-01\' AND \'2018-03-31\'\r\nWHERE p.age_y BETWEEN 35 AND 74 AND p.TYPEAREA IN (1,3)\r\nGROUP BY p.CID', 'Y=ไดรับการคัดกรองความดันโลหิตสูง', null, null, 'qof2561', null, null, '2017-08-03 13:03:52', '1', '2017-08-07 13:45:22', '1');
INSERT INTO `dhdc_adhoc` VALUES ('4', '2.2 รอยละของประชากรไทยอายุ 35-74 ป ที่ไดรับการคัดกรองและวินิจฉัยเปน ความดันโลหิตสูง', 'SELECT h.hoscode,h.hosname,tt.B,tt.A,ROUND(tt.A*100/tt.B,2) RATE FROM (\r\nSELECT t.HOSPCODE,COUNT(t.HOSPCODE) B , COUNT(if(t.`CHECK` is NULL ,NULL,t.HOSPCODE)) A from\r\n(\r\n\r\nSELECT p.*,a.min_date_dx_ht DATE_DX_HT\r\n,if(a.min_date_dx_dm is null,NULL,\'Y\') \'CHECK\'\r\nfrom (\r\nSELECT p.HOSPCODE,p.PID,p.CID,concat(p.`NAME`,\' \',p.LNAME) NAME,p.SEX,p.age_y AGE,p.TYPEAREA \r\n,GROUP_CONCAT(a.SBP_1,\'/\',a.DBP_1) BP\r\n,GROUP_CONCAT(a.DATE_SERV) DATE_SCREEN\r\nFROM t_person_cid p\r\nINNER JOIN t_ncdscreen a ON p.CID = a.CID AND a.DATE_SERV BETWEEN \'2017-04-01\' AND \'2018-03-31\' AND a.SBP_1 is not NULL\r\nWHERE p.age_y BETWEEN 35 AND 74 AND p.TYPEAREA IN (1,3)\r\nGROUP BY p.CID \r\n) p LEFT JOIN t_dmht a ON p.CID = a.cid AND a.min_date_dx_ht BETWEEN  \'2017-04-01\' AND \'2018-03-31\'\r\n\r\n) t GROUP BY t.HOSPCODE\r\n) tt RIGHT JOIN chospital_amp h ON h.hoscode = tt.HOSPCODE', 'B=ประชากรไทยอายุ 35-74 ป ที่ไดรับการคัดกรอง,A=วินิจฉัยเปน ความดันโลหิตสูง', 'SELECT p.*,a.min_date_dx_ht DATE_DX_HT\r\n,if(a.min_date_dx_dm is null,NULL,\'Y\') \'CHECK\'\r\nfrom (\r\nSELECT p.HOSPCODE,p.PID,p.CID,concat(p.`NAME`,\' \',p.LNAME) NAME,p.SEX,p.age_y AGE,p.TYPEAREA \r\n,GROUP_CONCAT(a.SBP_1,\'/\',a.DBP_1) BP\r\n,GROUP_CONCAT(a.DATE_SERV) DATE_SCREEN\r\nFROM t_person_cid p\r\nINNER JOIN t_ncdscreen a ON p.CID = a.CID AND a.DATE_SERV BETWEEN  \'2017-04-01\' AND \'2018-03-31\'  AND a.SBP_1 is not NULL\r\nWHERE p.age_y BETWEEN 35 AND 74 AND p.TYPEAREA IN (1,3)\r\nGROUP BY p.CID \r\n) p LEFT JOIN t_dmht a ON p.CID = a.cid AND a.min_date_dx_ht BETWEEN  \'2017-04-01\' AND \'2018-03-31\'', 'Y=ไดรับการคัดกรอง', null, null, 'qof2561', null, null, '2017-08-03 13:32:24', '1', '2017-08-07 13:46:00', '1');
INSERT INTO `dhdc_adhoc` VALUES ('5', '3.รอยละของหญิงมีครรภไดรับการฝากครรภครั้งแรกภายใน 12 สัปดาห', '	SELECT h.hoscode,h.hosname,tt.B,tt.A,ROUND(tt.A*100/tt.B,2) RATE FROM (\r\nSELECT t.HOSPCODE,COUNT(t.HOSPCODE) B , COUNT(if(t.`CHECK` is NULL ,NULL,t.HOSPCODE)) A from\r\n(\r\nSELECT l.HOSPCODE,l.PID,l.cid CID,p.`NAME`,p.LNAME,l.GRAVIDA,l.BDATE \r\n,a.g1_ga G1_GA ,if(a.g1_ga<=12,\'Y\',NULL) \'CHECK\'\r\nFROM t_labor l\r\n\r\nINNER JOIN t_person_cid p ON l.cid = p.CID\r\nLEFT JOIN t_person_anc a  ON l.cid=a.cid AND l.bdate =a.bdate\r\n\r\nWHERE  p.check_typearea in(1,3) AND p.discharge IN(9)\r\nAND l.BDATE BETWEEN \'2017-04-01\' AND \'2018-03-31\'\r\n\r\n) t GROUP BY t.HOSPCODE\r\n) tt RIGHT JOIN chospital_amp h ON h.hoscode = tt.HOSPCODE\r\n', '', 'SELECT l.HOSPCODE,l.PID,l.cid CID,p.`NAME`,p.LNAME,l.GRAVIDA,l.BDATE \r\n,a.g1_ga G1_GA ,if(a.g1_ga<=12,\'Y\',NULL) \'CHECK\'\r\nFROM t_labor l\r\n\r\nINNER JOIN t_person_cid p ON l.cid = p.CID\r\nLEFT JOIN t_person_anc a  ON l.cid=a.cid AND l.bdate =a.bdate\r\n\r\nWHERE  p.check_typearea in(1,3) AND p.discharge IN(9)\r\nAND l.BDATE BETWEEN \'2017-04-01\' AND \'2018-03-31\'\r\n', 'Y=ฝากครั้งแรกภายใน 12 สัปดาห์', null, null, 'qof2561', null, null, '2017-08-07 13:48:04', '1', '2017-08-07 14:10:32', '1');
INSERT INTO `dhdc_adhoc` VALUES ('6', '4.รอยละสะสมความครอบคลุมการตรวจคัดกรองมะเร็งปากมดลูกในสตรี 30- 60 ป ภายใน 5 ปี', '', '', '', '', null, null, 'qof2561', null, null, '2017-08-07 13:48:44', '1', '2017-08-07 13:48:44', '1');
INSERT INTO `dhdc_adhoc` VALUES ('7', '5.1 รอยละการใชยาปฏิชีวนะอยางรับผิดชอบในผูปวยนอกโรคอุจจาระรวง เฉียบพลัน (Acute Diarrhea)', '', '', '', '', null, null, 'qof2561', null, null, '2017-08-07 13:49:13', '1', '2017-08-07 13:49:13', '1');
INSERT INTO `dhdc_adhoc` VALUES ('8', '5.2 รอยละการใชยาปฏิชีวนะอยางรับผิดชอบในผูปวยนอกโรคติดเชื้อระบบ ทางเดินหายใจ (Respiratory Infection)', '', '', '', '', null, null, 'qof2561', null, null, '2017-08-07 13:49:33', '1', '2017-08-07 13:49:33', '1');
