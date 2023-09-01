Return-Path: <SRS0=48SA=ER=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0011.nifty.com (mta-snd00001.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id 12C4B3858D20
	for <cygwin-patches@cygwin.com>; Fri,  1 Sep 2023 10:04:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 12C4B3858D20
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0011.nifty.com with ESMTP
          id <20230901100449878.PTAB.104149.localhost.localdomain@nifty.com>;
          Fri, 1 Sep 2023 19:04:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: Implement sound mixer device.
Date: Fri,  1 Sep 2023 19:04:30 +0900
Message-Id: <20230901100430.58560-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch adds implementation of OSS-based sound mixer device. This
allows applications to change the sound playing volume.

NOTE: Currently, the recording volume cannot be changed.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/Makefile.am               |    1 +
 winsup/cygwin/devices.cc                | 1390 ++++++++++++-----------
 winsup/cygwin/devices.in                |    1 +
 winsup/cygwin/dtable.cc                 |    3 +
 winsup/cygwin/fhandler/mixer.cc         |  152 +++
 winsup/cygwin/local_includes/devices.h  |    1 +
 winsup/cygwin/local_includes/fhandler.h |   29 +
 winsup/cygwin/release/3.5.0             |    2 +
 8 files changed, 892 insertions(+), 687 deletions(-)
 create mode 100644 winsup/cygwin/fhandler/mixer.cc

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index bfb5ead10..9912b5399 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -89,6 +89,7 @@ FHANDLER_FILES= \
 	fhandler/dsp.cc \
 	fhandler/fifo.cc \
 	fhandler/floppy.cc \
+	fhandler/mixer.cc \
 	fhandler/mqueue.cc \
 	fhandler/netdrive.cc \
 	fhandler/nodevice.cc \
diff --git a/winsup/cygwin/devices.cc b/winsup/cygwin/devices.cc
index 72c83d6e6..acdc54412 100644
--- a/winsup/cygwin/devices.cc
+++ b/winsup/cygwin/devices.cc
@@ -341,6 +341,7 @@ const _RDATA _device dev_storage[] =
   {"/dev/fd14", BRACK(FHDEV(DEV_FLOPPY_MAJOR, 14)), "\\Device\\Floppy14", exists_ntdev, S_IFBLK, true},
   {"/dev/fd15", BRACK(FHDEV(DEV_FLOPPY_MAJOR, 15)), "\\Device\\Floppy15", exists_ntdev, S_IFBLK, true},
   {"/dev/full", BRACK(FH_FULL), "\\Device\\Null", exists_ntdev, S_IFCHR, true},
+  {"/dev/mixer", BRACK(FH_OSS_MIXER), "\\Device\\Null", exists_ntdev, S_IFCHR, true},
   {"/dev/nst0", BRACK(FHDEV(DEV_TAPE_MAJOR, 128)), "\\Device\\Tape0", exists_ntdev, S_IFCHR, true},
   {"/dev/nst1", BRACK(FHDEV(DEV_TAPE_MAJOR, 129)), "\\Device\\Tape1", exists_ntdev, S_IFCHR, true},
   {"/dev/nst2", BRACK(FHDEV(DEV_TAPE_MAJOR, 130)), "\\Device\\Tape2", exists_ntdev, S_IFCHR, true},
@@ -1029,9 +1030,9 @@ const _RDATA _device dev_storage[] =
 
 const _device *cons_dev = dev_storage + 20;
 const _device *console_dev = dev_storage + 148;
-const _device *ptym_dev = dev_storage + 724;
-const _device *ptys_dev = dev_storage + 298;
-const _device *urandom_dev = dev_storage + 719;
+const _device *ptym_dev = dev_storage + 725;
+const _device *ptys_dev = dev_storage + 299;
+const _device *urandom_dev = dev_storage + 720;
 
 
 static KR_device_t KR_find_keyword (const char *KR_keyword, int KR_length)
@@ -1061,7 +1062,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":pipe", 5) == 0)
             {
 {
-return dev_storage + 723;
+return dev_storage + 724;
 
 }
             }
@@ -1076,7 +1077,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":fifo", 5) == 0)
             {
 {
-return dev_storage + 722;
+return dev_storage + 723;
 
 }
             }
@@ -1100,7 +1101,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":ptym9", 6) == 0)
             {
 {
-return dev_storage + 733;
+return dev_storage + 734;
 
 }
             }
@@ -1115,7 +1116,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":ptym8", 6) == 0)
             {
 {
-return dev_storage + 732;
+return dev_storage + 733;
 
 }
             }
@@ -1130,7 +1131,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":ptym7", 6) == 0)
             {
 {
-return dev_storage + 731;
+return dev_storage + 732;
 
 }
             }
@@ -1145,7 +1146,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":ptym6", 6) == 0)
             {
 {
-return dev_storage + 730;
+return dev_storage + 731;
 
 }
             }
@@ -1160,7 +1161,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":ptym5", 6) == 0)
             {
 {
-return dev_storage + 729;
+return dev_storage + 730;
 
 }
             }
@@ -1175,7 +1176,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":ptym4", 6) == 0)
             {
 {
-return dev_storage + 728;
+return dev_storage + 729;
 
 }
             }
@@ -1190,7 +1191,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":ptym3", 6) == 0)
             {
 {
-return dev_storage + 727;
+return dev_storage + 728;
 
 }
             }
@@ -1205,7 +1206,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":ptym2", 6) == 0)
             {
 {
-return dev_storage + 726;
+return dev_storage + 727;
 
 }
             }
@@ -1220,7 +1221,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":ptym1", 6) == 0)
             {
 {
-return dev_storage + 725;
+return dev_storage + 726;
 
 }
             }
@@ -1235,7 +1236,7 @@ return	NULL;
           if (strncmp (KR_keyword, ":ptym0", 6) == 0)
             {
 {
-return dev_storage + 724;
+return dev_storage + 725;
 
 }
             }
@@ -1277,7 +1278,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym99", 7) == 0)
                 {
 {
-return dev_storage + 823;
+return dev_storage + 824;
 
 }
                 }
@@ -1292,7 +1293,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym98", 7) == 0)
                 {
 {
-return dev_storage + 822;
+return dev_storage + 823;
 
 }
                 }
@@ -1307,7 +1308,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym97", 7) == 0)
                 {
 {
-return dev_storage + 821;
+return dev_storage + 822;
 
 }
                 }
@@ -1322,7 +1323,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym96", 7) == 0)
                 {
 {
-return dev_storage + 820;
+return dev_storage + 821;
 
 }
                 }
@@ -1337,7 +1338,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym95", 7) == 0)
                 {
 {
-return dev_storage + 819;
+return dev_storage + 820;
 
 }
                 }
@@ -1352,7 +1353,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym94", 7) == 0)
                 {
 {
-return dev_storage + 818;
+return dev_storage + 819;
 
 }
                 }
@@ -1367,7 +1368,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym93", 7) == 0)
                 {
 {
-return dev_storage + 817;
+return dev_storage + 818;
 
 }
                 }
@@ -1382,7 +1383,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym92", 7) == 0)
                 {
 {
-return dev_storage + 816;
+return dev_storage + 817;
 
 }
                 }
@@ -1397,7 +1398,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym91", 7) == 0)
                 {
 {
-return dev_storage + 815;
+return dev_storage + 816;
 
 }
                 }
@@ -1412,7 +1413,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym90", 7) == 0)
                 {
 {
-return dev_storage + 814;
+return dev_storage + 815;
 
 }
                 }
@@ -1436,7 +1437,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym89", 7) == 0)
                 {
 {
-return dev_storage + 813;
+return dev_storage + 814;
 
 }
                 }
@@ -1451,7 +1452,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym88", 7) == 0)
                 {
 {
-return dev_storage + 812;
+return dev_storage + 813;
 
 }
                 }
@@ -1466,7 +1467,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym87", 7) == 0)
                 {
 {
-return dev_storage + 811;
+return dev_storage + 812;
 
 }
                 }
@@ -1481,7 +1482,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym86", 7) == 0)
                 {
 {
-return dev_storage + 810;
+return dev_storage + 811;
 
 }
                 }
@@ -1496,7 +1497,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym85", 7) == 0)
                 {
 {
-return dev_storage + 809;
+return dev_storage + 810;
 
 }
                 }
@@ -1511,7 +1512,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym84", 7) == 0)
                 {
 {
-return dev_storage + 808;
+return dev_storage + 809;
 
 }
                 }
@@ -1526,7 +1527,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym83", 7) == 0)
                 {
 {
-return dev_storage + 807;
+return dev_storage + 808;
 
 }
                 }
@@ -1541,7 +1542,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym82", 7) == 0)
                 {
 {
-return dev_storage + 806;
+return dev_storage + 807;
 
 }
                 }
@@ -1556,7 +1557,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym81", 7) == 0)
                 {
 {
-return dev_storage + 805;
+return dev_storage + 806;
 
 }
                 }
@@ -1571,7 +1572,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym80", 7) == 0)
                 {
 {
-return dev_storage + 804;
+return dev_storage + 805;
 
 }
                 }
@@ -1595,7 +1596,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym79", 7) == 0)
                 {
 {
-return dev_storage + 803;
+return dev_storage + 804;
 
 }
                 }
@@ -1610,7 +1611,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym78", 7) == 0)
                 {
 {
-return dev_storage + 802;
+return dev_storage + 803;
 
 }
                 }
@@ -1625,7 +1626,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym77", 7) == 0)
                 {
 {
-return dev_storage + 801;
+return dev_storage + 802;
 
 }
                 }
@@ -1640,7 +1641,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym76", 7) == 0)
                 {
 {
-return dev_storage + 800;
+return dev_storage + 801;
 
 }
                 }
@@ -1655,7 +1656,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym75", 7) == 0)
                 {
 {
-return dev_storage + 799;
+return dev_storage + 800;
 
 }
                 }
@@ -1670,7 +1671,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym74", 7) == 0)
                 {
 {
-return dev_storage + 798;
+return dev_storage + 799;
 
 }
                 }
@@ -1685,7 +1686,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym73", 7) == 0)
                 {
 {
-return dev_storage + 797;
+return dev_storage + 798;
 
 }
                 }
@@ -1700,7 +1701,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym72", 7) == 0)
                 {
 {
-return dev_storage + 796;
+return dev_storage + 797;
 
 }
                 }
@@ -1715,7 +1716,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym71", 7) == 0)
                 {
 {
-return dev_storage + 795;
+return dev_storage + 796;
 
 }
                 }
@@ -1730,7 +1731,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym70", 7) == 0)
                 {
 {
-return dev_storage + 794;
+return dev_storage + 795;
 
 }
                 }
@@ -1754,7 +1755,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym69", 7) == 0)
                 {
 {
-return dev_storage + 793;
+return dev_storage + 794;
 
 }
                 }
@@ -1769,7 +1770,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym68", 7) == 0)
                 {
 {
-return dev_storage + 792;
+return dev_storage + 793;
 
 }
                 }
@@ -1784,7 +1785,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym67", 7) == 0)
                 {
 {
-return dev_storage + 791;
+return dev_storage + 792;
 
 }
                 }
@@ -1799,7 +1800,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym66", 7) == 0)
                 {
 {
-return dev_storage + 790;
+return dev_storage + 791;
 
 }
                 }
@@ -1814,7 +1815,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym65", 7) == 0)
                 {
 {
-return dev_storage + 789;
+return dev_storage + 790;
 
 }
                 }
@@ -1829,7 +1830,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym64", 7) == 0)
                 {
 {
-return dev_storage + 788;
+return dev_storage + 789;
 
 }
                 }
@@ -1844,7 +1845,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym63", 7) == 0)
                 {
 {
-return dev_storage + 787;
+return dev_storage + 788;
 
 }
                 }
@@ -1859,7 +1860,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym62", 7) == 0)
                 {
 {
-return dev_storage + 786;
+return dev_storage + 787;
 
 }
                 }
@@ -1874,7 +1875,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym61", 7) == 0)
                 {
 {
-return dev_storage + 785;
+return dev_storage + 786;
 
 }
                 }
@@ -1889,7 +1890,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym60", 7) == 0)
                 {
 {
-return dev_storage + 784;
+return dev_storage + 785;
 
 }
                 }
@@ -1913,7 +1914,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym59", 7) == 0)
                 {
 {
-return dev_storage + 783;
+return dev_storage + 784;
 
 }
                 }
@@ -1928,7 +1929,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym58", 7) == 0)
                 {
 {
-return dev_storage + 782;
+return dev_storage + 783;
 
 }
                 }
@@ -1943,7 +1944,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym57", 7) == 0)
                 {
 {
-return dev_storage + 781;
+return dev_storage + 782;
 
 }
                 }
@@ -1958,7 +1959,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym56", 7) == 0)
                 {
 {
-return dev_storage + 780;
+return dev_storage + 781;
 
 }
                 }
@@ -1973,7 +1974,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym55", 7) == 0)
                 {
 {
-return dev_storage + 779;
+return dev_storage + 780;
 
 }
                 }
@@ -1988,7 +1989,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym54", 7) == 0)
                 {
 {
-return dev_storage + 778;
+return dev_storage + 779;
 
 }
                 }
@@ -2003,7 +2004,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym53", 7) == 0)
                 {
 {
-return dev_storage + 777;
+return dev_storage + 778;
 
 }
                 }
@@ -2018,7 +2019,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym52", 7) == 0)
                 {
 {
-return dev_storage + 776;
+return dev_storage + 777;
 
 }
                 }
@@ -2033,7 +2034,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym51", 7) == 0)
                 {
 {
-return dev_storage + 775;
+return dev_storage + 776;
 
 }
                 }
@@ -2048,7 +2049,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym50", 7) == 0)
                 {
 {
-return dev_storage + 774;
+return dev_storage + 775;
 
 }
                 }
@@ -2072,7 +2073,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym49", 7) == 0)
                 {
 {
-return dev_storage + 773;
+return dev_storage + 774;
 
 }
                 }
@@ -2087,7 +2088,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym48", 7) == 0)
                 {
 {
-return dev_storage + 772;
+return dev_storage + 773;
 
 }
                 }
@@ -2102,7 +2103,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym47", 7) == 0)
                 {
 {
-return dev_storage + 771;
+return dev_storage + 772;
 
 }
                 }
@@ -2117,7 +2118,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym46", 7) == 0)
                 {
 {
-return dev_storage + 770;
+return dev_storage + 771;
 
 }
                 }
@@ -2132,7 +2133,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym45", 7) == 0)
                 {
 {
-return dev_storage + 769;
+return dev_storage + 770;
 
 }
                 }
@@ -2147,7 +2148,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym44", 7) == 0)
                 {
 {
-return dev_storage + 768;
+return dev_storage + 769;
 
 }
                 }
@@ -2162,7 +2163,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym43", 7) == 0)
                 {
 {
-return dev_storage + 767;
+return dev_storage + 768;
 
 }
                 }
@@ -2177,7 +2178,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym42", 7) == 0)
                 {
 {
-return dev_storage + 766;
+return dev_storage + 767;
 
 }
                 }
@@ -2192,7 +2193,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym41", 7) == 0)
                 {
 {
-return dev_storage + 765;
+return dev_storage + 766;
 
 }
                 }
@@ -2207,7 +2208,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym40", 7) == 0)
                 {
 {
-return dev_storage + 764;
+return dev_storage + 765;
 
 }
                 }
@@ -2231,7 +2232,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym39", 7) == 0)
                 {
 {
-return dev_storage + 763;
+return dev_storage + 764;
 
 }
                 }
@@ -2246,7 +2247,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym38", 7) == 0)
                 {
 {
-return dev_storage + 762;
+return dev_storage + 763;
 
 }
                 }
@@ -2261,7 +2262,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym37", 7) == 0)
                 {
 {
-return dev_storage + 761;
+return dev_storage + 762;
 
 }
                 }
@@ -2276,7 +2277,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym36", 7) == 0)
                 {
 {
-return dev_storage + 760;
+return dev_storage + 761;
 
 }
                 }
@@ -2291,7 +2292,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym35", 7) == 0)
                 {
 {
-return dev_storage + 759;
+return dev_storage + 760;
 
 }
                 }
@@ -2306,7 +2307,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym34", 7) == 0)
                 {
 {
-return dev_storage + 758;
+return dev_storage + 759;
 
 }
                 }
@@ -2321,7 +2322,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym33", 7) == 0)
                 {
 {
-return dev_storage + 757;
+return dev_storage + 758;
 
 }
                 }
@@ -2336,7 +2337,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym32", 7) == 0)
                 {
 {
-return dev_storage + 756;
+return dev_storage + 757;
 
 }
                 }
@@ -2351,7 +2352,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym31", 7) == 0)
                 {
 {
-return dev_storage + 755;
+return dev_storage + 756;
 
 }
                 }
@@ -2366,7 +2367,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym30", 7) == 0)
                 {
 {
-return dev_storage + 754;
+return dev_storage + 755;
 
 }
                 }
@@ -2390,7 +2391,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym29", 7) == 0)
                 {
 {
-return dev_storage + 753;
+return dev_storage + 754;
 
 }
                 }
@@ -2405,7 +2406,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym28", 7) == 0)
                 {
 {
-return dev_storage + 752;
+return dev_storage + 753;
 
 }
                 }
@@ -2420,7 +2421,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym27", 7) == 0)
                 {
 {
-return dev_storage + 751;
+return dev_storage + 752;
 
 }
                 }
@@ -2435,7 +2436,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym26", 7) == 0)
                 {
 {
-return dev_storage + 750;
+return dev_storage + 751;
 
 }
                 }
@@ -2450,7 +2451,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym25", 7) == 0)
                 {
 {
-return dev_storage + 749;
+return dev_storage + 750;
 
 }
                 }
@@ -2465,7 +2466,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym24", 7) == 0)
                 {
 {
-return dev_storage + 748;
+return dev_storage + 749;
 
 }
                 }
@@ -2480,7 +2481,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym23", 7) == 0)
                 {
 {
-return dev_storage + 747;
+return dev_storage + 748;
 
 }
                 }
@@ -2495,7 +2496,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym22", 7) == 0)
                 {
 {
-return dev_storage + 746;
+return dev_storage + 747;
 
 }
                 }
@@ -2510,7 +2511,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym21", 7) == 0)
                 {
 {
-return dev_storage + 745;
+return dev_storage + 746;
 
 }
                 }
@@ -2525,7 +2526,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym20", 7) == 0)
                 {
 {
-return dev_storage + 744;
+return dev_storage + 745;
 
 }
                 }
@@ -2549,7 +2550,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym19", 7) == 0)
                 {
 {
-return dev_storage + 743;
+return dev_storage + 744;
 
 }
                 }
@@ -2564,7 +2565,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym18", 7) == 0)
                 {
 {
-return dev_storage + 742;
+return dev_storage + 743;
 
 }
                 }
@@ -2579,7 +2580,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym17", 7) == 0)
                 {
 {
-return dev_storage + 741;
+return dev_storage + 742;
 
 }
                 }
@@ -2594,7 +2595,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym16", 7) == 0)
                 {
 {
-return dev_storage + 740;
+return dev_storage + 741;
 
 }
                 }
@@ -2609,7 +2610,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym15", 7) == 0)
                 {
 {
-return dev_storage + 739;
+return dev_storage + 740;
 
 }
                 }
@@ -2624,7 +2625,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym14", 7) == 0)
                 {
 {
-return dev_storage + 738;
+return dev_storage + 739;
 
 }
                 }
@@ -2639,7 +2640,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym13", 7) == 0)
                 {
 {
-return dev_storage + 737;
+return dev_storage + 738;
 
 }
                 }
@@ -2654,7 +2655,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym12", 7) == 0)
                 {
 {
-return dev_storage + 736;
+return dev_storage + 737;
 
 }
                 }
@@ -2669,7 +2670,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym11", 7) == 0)
                 {
 {
-return dev_storage + 735;
+return dev_storage + 736;
 
 }
                 }
@@ -2684,7 +2685,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym10", 7) == 0)
                 {
 {
-return dev_storage + 734;
+return dev_storage + 735;
 
 }
                 }
@@ -2714,7 +2715,7 @@ return	NULL;
           if (strncmp (KR_keyword, "/dev/tty", 8) == 0)
             {
 {
-return dev_storage + 590;
+return dev_storage + 591;
 
 }
             }
@@ -2747,7 +2748,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st9", 8) == 0)
                 {
 {
-return dev_storage + 468;
+return dev_storage + 469;
 
 }
                 }
@@ -2762,7 +2763,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/sr9", 8) == 0)
                 {
 {
-return dev_storage + 452;
+return dev_storage + 453;
 
 }
                 }
@@ -2792,7 +2793,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym119", 8) == 0)
                 {
 {
-return dev_storage + 843;
+return dev_storage + 844;
 
 }
                 }
@@ -2807,7 +2808,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym109", 8) == 0)
                 {
 {
-return dev_storage + 833;
+return dev_storage + 834;
 
 }
                 }
@@ -2831,7 +2832,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st8", 8) == 0)
                 {
 {
-return dev_storage + 467;
+return dev_storage + 468;
 
 }
                 }
@@ -2846,7 +2847,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/sr8", 8) == 0)
                 {
 {
-return dev_storage + 451;
+return dev_storage + 452;
 
 }
                 }
@@ -2876,7 +2877,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym118", 8) == 0)
                 {
 {
-return dev_storage + 842;
+return dev_storage + 843;
 
 }
                 }
@@ -2891,7 +2892,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym108", 8) == 0)
                 {
 {
-return dev_storage + 832;
+return dev_storage + 833;
 
 }
                 }
@@ -2915,7 +2916,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st7", 8) == 0)
                 {
 {
-return dev_storage + 466;
+return dev_storage + 467;
 
 }
                 }
@@ -2930,7 +2931,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/sr7", 8) == 0)
                 {
 {
-return dev_storage + 450;
+return dev_storage + 451;
 
 }
                 }
@@ -2960,7 +2961,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym127", 8) == 0)
                 {
 {
-return dev_storage + 851;
+return dev_storage + 852;
 
 }
                 }
@@ -2975,7 +2976,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym117", 8) == 0)
                 {
 {
-return dev_storage + 841;
+return dev_storage + 842;
 
 }
                 }
@@ -2990,7 +2991,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym107", 8) == 0)
                 {
 {
-return dev_storage + 831;
+return dev_storage + 832;
 
 }
                 }
@@ -3014,7 +3015,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st6", 8) == 0)
                 {
 {
-return dev_storage + 465;
+return dev_storage + 466;
 
 }
                 }
@@ -3029,7 +3030,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/sr6", 8) == 0)
                 {
 {
-return dev_storage + 449;
+return dev_storage + 450;
 
 }
                 }
@@ -3059,7 +3060,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym126", 8) == 0)
                 {
 {
-return dev_storage + 850;
+return dev_storage + 851;
 
 }
                 }
@@ -3074,7 +3075,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym116", 8) == 0)
                 {
 {
-return dev_storage + 840;
+return dev_storage + 841;
 
 }
                 }
@@ -3089,7 +3090,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym106", 8) == 0)
                 {
 {
-return dev_storage + 830;
+return dev_storage + 831;
 
 }
                 }
@@ -3113,7 +3114,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st5", 8) == 0)
                 {
 {
-return dev_storage + 464;
+return dev_storage + 465;
 
 }
                 }
@@ -3128,7 +3129,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/sr5", 8) == 0)
                 {
 {
-return dev_storage + 448;
+return dev_storage + 449;
 
 }
                 }
@@ -3158,7 +3159,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym125", 8) == 0)
                 {
 {
-return dev_storage + 849;
+return dev_storage + 850;
 
 }
                 }
@@ -3173,7 +3174,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym115", 8) == 0)
                 {
 {
-return dev_storage + 839;
+return dev_storage + 840;
 
 }
                 }
@@ -3188,7 +3189,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym105", 8) == 0)
                 {
 {
-return dev_storage + 829;
+return dev_storage + 830;
 
 }
                 }
@@ -3212,7 +3213,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st4", 8) == 0)
                 {
 {
-return dev_storage + 463;
+return dev_storage + 464;
 
 }
                 }
@@ -3227,7 +3228,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/sr4", 8) == 0)
                 {
 {
-return dev_storage + 447;
+return dev_storage + 448;
 
 }
                 }
@@ -3257,7 +3258,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym124", 8) == 0)
                 {
 {
-return dev_storage + 848;
+return dev_storage + 849;
 
 }
                 }
@@ -3272,7 +3273,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym114", 8) == 0)
                 {
 {
-return dev_storage + 838;
+return dev_storage + 839;
 
 }
                 }
@@ -3287,7 +3288,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym104", 8) == 0)
                 {
 {
-return dev_storage + 828;
+return dev_storage + 829;
 
 }
                 }
@@ -3311,7 +3312,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st3", 8) == 0)
                 {
 {
-return dev_storage + 462;
+return dev_storage + 463;
 
 }
                 }
@@ -3326,7 +3327,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/sr3", 8) == 0)
                 {
 {
-return dev_storage + 446;
+return dev_storage + 447;
 
 }
                 }
@@ -3356,7 +3357,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym123", 8) == 0)
                 {
 {
-return dev_storage + 847;
+return dev_storage + 848;
 
 }
                 }
@@ -3371,7 +3372,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym113", 8) == 0)
                 {
 {
-return dev_storage + 837;
+return dev_storage + 838;
 
 }
                 }
@@ -3386,7 +3387,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym103", 8) == 0)
                 {
 {
-return dev_storage + 827;
+return dev_storage + 828;
 
 }
                 }
@@ -3410,7 +3411,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st2", 8) == 0)
                 {
 {
-return dev_storage + 461;
+return dev_storage + 462;
 
 }
                 }
@@ -3425,7 +3426,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/sr2", 8) == 0)
                 {
 {
-return dev_storage + 445;
+return dev_storage + 446;
 
 }
                 }
@@ -3455,7 +3456,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym122", 8) == 0)
                 {
 {
-return dev_storage + 846;
+return dev_storage + 847;
 
 }
                 }
@@ -3470,7 +3471,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym112", 8) == 0)
                 {
 {
-return dev_storage + 836;
+return dev_storage + 837;
 
 }
                 }
@@ -3485,7 +3486,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym102", 8) == 0)
                 {
 {
-return dev_storage + 826;
+return dev_storage + 827;
 
 }
                 }
@@ -3509,7 +3510,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st1", 8) == 0)
                 {
 {
-return dev_storage + 460;
+return dev_storage + 461;
 
 }
                 }
@@ -3524,7 +3525,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/sr1", 8) == 0)
                 {
 {
-return dev_storage + 444;
+return dev_storage + 445;
 
 }
                 }
@@ -3554,7 +3555,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym121", 8) == 0)
                 {
 {
-return dev_storage + 845;
+return dev_storage + 846;
 
 }
                 }
@@ -3569,7 +3570,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym111", 8) == 0)
                 {
 {
-return dev_storage + 835;
+return dev_storage + 836;
 
 }
                 }
@@ -3584,7 +3585,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym101", 8) == 0)
                 {
 {
-return dev_storage + 825;
+return dev_storage + 826;
 
 }
                 }
@@ -3608,7 +3609,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st0", 8) == 0)
                 {
 {
-return dev_storage + 459;
+return dev_storage + 460;
 
 }
                 }
@@ -3623,7 +3624,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/sr0", 8) == 0)
                 {
 {
-return dev_storage + 443;
+return dev_storage + 444;
 
 }
                 }
@@ -3653,7 +3654,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym120", 8) == 0)
                 {
 {
-return dev_storage + 844;
+return dev_storage + 845;
 
 }
                 }
@@ -3668,7 +3669,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym110", 8) == 0)
                 {
 {
-return dev_storage + 834;
+return dev_storage + 835;
 
 }
                 }
@@ -3683,7 +3684,7 @@ return	NULL;
               if (strncmp (KR_keyword, ":ptym100", 8) == 0)
                 {
 {
-return dev_storage + 824;
+return dev_storage + 825;
 
 }
                 }
@@ -3713,7 +3714,7 @@ return	NULL;
           if (strncmp (KR_keyword, "/dev/ptmx", 9) == 0)
             {
 {
-return dev_storage + 297;
+return dev_storage + 298;
 
 }
             }
@@ -3728,7 +3729,7 @@ return	NULL;
           if (strncmp (KR_keyword, "/dev/zero", 9) == 0)
             {
 {
-return dev_storage + 721;
+return dev_storage + 722;
 
 }
             }
@@ -3746,7 +3747,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/null", 9) == 0)
                 {
 {
-return dev_storage + 296;
+return dev_storage + 297;
 
 }
                 }
@@ -3785,7 +3786,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/pty9", 9) == 0)
                 {
 {
-return dev_storage + 307;
+return dev_storage + 308;
 
 }
                 }
@@ -3800,7 +3801,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/nst9", 9) == 0)
                 {
 {
-return dev_storage + 177;
+return dev_storage + 178;
 
 }
                 }
@@ -3830,7 +3831,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/scd9", 9) == 0)
                 {
 {
-return dev_storage + 436;
+return dev_storage + 437;
 
 }
                 }
@@ -3845,7 +3846,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st99", 9) == 0)
                 {
 {
-return dev_storage + 558;
+return dev_storage + 559;
 
 }
                 }
@@ -3860,7 +3861,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st89", 9) == 0)
                 {
 {
-return dev_storage + 548;
+return dev_storage + 549;
 
 }
                 }
@@ -3875,7 +3876,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st79", 9) == 0)
                 {
 {
-return dev_storage + 538;
+return dev_storage + 539;
 
 }
                 }
@@ -3890,7 +3891,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st69", 9) == 0)
                 {
 {
-return dev_storage + 528;
+return dev_storage + 529;
 
 }
                 }
@@ -3905,7 +3906,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st59", 9) == 0)
                 {
 {
-return dev_storage + 518;
+return dev_storage + 519;
 
 }
                 }
@@ -3920,7 +3921,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st49", 9) == 0)
                 {
 {
-return dev_storage + 508;
+return dev_storage + 509;
 
 }
                 }
@@ -3935,7 +3936,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st39", 9) == 0)
                 {
 {
-return dev_storage + 498;
+return dev_storage + 499;
 
 }
                 }
@@ -3950,7 +3951,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st29", 9) == 0)
                 {
 {
-return dev_storage + 488;
+return dev_storage + 489;
 
 }
                 }
@@ -3965,7 +3966,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st19", 9) == 0)
                 {
 {
-return dev_storage + 478;
+return dev_storage + 479;
 
 }
                 }
@@ -3989,7 +3990,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/pty8", 9) == 0)
                 {
 {
-return dev_storage + 306;
+return dev_storage + 307;
 
 }
                 }
@@ -4004,7 +4005,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/nst8", 9) == 0)
                 {
 {
-return dev_storage + 176;
+return dev_storage + 177;
 
 }
                 }
@@ -4034,7 +4035,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/scd8", 9) == 0)
                 {
 {
-return dev_storage + 435;
+return dev_storage + 436;
 
 }
                 }
@@ -4049,7 +4050,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st98", 9) == 0)
                 {
 {
-return dev_storage + 557;
+return dev_storage + 558;
 
 }
                 }
@@ -4064,7 +4065,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st88", 9) == 0)
                 {
 {
-return dev_storage + 547;
+return dev_storage + 548;
 
 }
                 }
@@ -4079,7 +4080,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st78", 9) == 0)
                 {
 {
-return dev_storage + 537;
+return dev_storage + 538;
 
 }
                 }
@@ -4094,7 +4095,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st68", 9) == 0)
                 {
 {
-return dev_storage + 527;
+return dev_storage + 528;
 
 }
                 }
@@ -4109,7 +4110,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st58", 9) == 0)
                 {
 {
-return dev_storage + 517;
+return dev_storage + 518;
 
 }
                 }
@@ -4124,7 +4125,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st48", 9) == 0)
                 {
 {
-return dev_storage + 507;
+return dev_storage + 508;
 
 }
                 }
@@ -4139,7 +4140,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st38", 9) == 0)
                 {
 {
-return dev_storage + 497;
+return dev_storage + 498;
 
 }
                 }
@@ -4154,7 +4155,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st28", 9) == 0)
                 {
 {
-return dev_storage + 487;
+return dev_storage + 488;
 
 }
                 }
@@ -4169,7 +4170,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st18", 9) == 0)
                 {
 {
-return dev_storage + 477;
+return dev_storage + 478;
 
 }
                 }
@@ -4193,7 +4194,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/pty7", 9) == 0)
                 {
 {
-return dev_storage + 305;
+return dev_storage + 306;
 
 }
                 }
@@ -4208,7 +4209,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/nst7", 9) == 0)
                 {
 {
-return dev_storage + 175;
+return dev_storage + 176;
 
 }
                 }
@@ -4238,7 +4239,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/scd7", 9) == 0)
                 {
 {
-return dev_storage + 434;
+return dev_storage + 435;
 
 }
                 }
@@ -4253,7 +4254,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st97", 9) == 0)
                 {
 {
-return dev_storage + 556;
+return dev_storage + 557;
 
 }
                 }
@@ -4268,7 +4269,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st87", 9) == 0)
                 {
 {
-return dev_storage + 546;
+return dev_storage + 547;
 
 }
                 }
@@ -4283,7 +4284,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st77", 9) == 0)
                 {
 {
-return dev_storage + 536;
+return dev_storage + 537;
 
 }
                 }
@@ -4298,7 +4299,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st67", 9) == 0)
                 {
 {
-return dev_storage + 526;
+return dev_storage + 527;
 
 }
                 }
@@ -4313,7 +4314,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st57", 9) == 0)
                 {
 {
-return dev_storage + 516;
+return dev_storage + 517;
 
 }
                 }
@@ -4328,7 +4329,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st47", 9) == 0)
                 {
 {
-return dev_storage + 506;
+return dev_storage + 507;
 
 }
                 }
@@ -4343,7 +4344,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st37", 9) == 0)
                 {
 {
-return dev_storage + 496;
+return dev_storage + 497;
 
 }
                 }
@@ -4358,7 +4359,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st27", 9) == 0)
                 {
 {
-return dev_storage + 486;
+return dev_storage + 487;
 
 }
                 }
@@ -4373,7 +4374,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st17", 9) == 0)
                 {
 {
-return dev_storage + 476;
+return dev_storage + 477;
 
 }
                 }
@@ -4397,7 +4398,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/pty6", 9) == 0)
                 {
 {
-return dev_storage + 304;
+return dev_storage + 305;
 
 }
                 }
@@ -4412,7 +4413,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/nst6", 9) == 0)
                 {
 {
-return dev_storage + 174;
+return dev_storage + 175;
 
 }
                 }
@@ -4442,7 +4443,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/scd6", 9) == 0)
                 {
 {
-return dev_storage + 433;
+return dev_storage + 434;
 
 }
                 }
@@ -4457,7 +4458,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st96", 9) == 0)
                 {
 {
-return dev_storage + 555;
+return dev_storage + 556;
 
 }
                 }
@@ -4472,7 +4473,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st86", 9) == 0)
                 {
 {
-return dev_storage + 545;
+return dev_storage + 546;
 
 }
                 }
@@ -4487,7 +4488,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st76", 9) == 0)
                 {
 {
-return dev_storage + 535;
+return dev_storage + 536;
 
 }
                 }
@@ -4502,7 +4503,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st66", 9) == 0)
                 {
 {
-return dev_storage + 525;
+return dev_storage + 526;
 
 }
                 }
@@ -4517,7 +4518,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st56", 9) == 0)
                 {
 {
-return dev_storage + 515;
+return dev_storage + 516;
 
 }
                 }
@@ -4532,7 +4533,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st46", 9) == 0)
                 {
 {
-return dev_storage + 505;
+return dev_storage + 506;
 
 }
                 }
@@ -4547,7 +4548,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st36", 9) == 0)
                 {
 {
-return dev_storage + 495;
+return dev_storage + 496;
 
 }
                 }
@@ -4562,7 +4563,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st26", 9) == 0)
                 {
 {
-return dev_storage + 485;
+return dev_storage + 486;
 
 }
                 }
@@ -4577,7 +4578,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st16", 9) == 0)
                 {
 {
-return dev_storage + 475;
+return dev_storage + 476;
 
 }
                 }
@@ -4601,7 +4602,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/pty5", 9) == 0)
                 {
 {
-return dev_storage + 303;
+return dev_storage + 304;
 
 }
                 }
@@ -4616,7 +4617,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/nst5", 9) == 0)
                 {
 {
-return dev_storage + 173;
+return dev_storage + 174;
 
 }
                 }
@@ -4646,7 +4647,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/scd5", 9) == 0)
                 {
 {
-return dev_storage + 432;
+return dev_storage + 433;
 
 }
                 }
@@ -4661,7 +4662,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st95", 9) == 0)
                 {
 {
-return dev_storage + 554;
+return dev_storage + 555;
 
 }
                 }
@@ -4676,7 +4677,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st85", 9) == 0)
                 {
 {
-return dev_storage + 544;
+return dev_storage + 545;
 
 }
                 }
@@ -4691,7 +4692,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st75", 9) == 0)
                 {
 {
-return dev_storage + 534;
+return dev_storage + 535;
 
 }
                 }
@@ -4706,7 +4707,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st65", 9) == 0)
                 {
 {
-return dev_storage + 524;
+return dev_storage + 525;
 
 }
                 }
@@ -4721,7 +4722,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st55", 9) == 0)
                 {
 {
-return dev_storage + 514;
+return dev_storage + 515;
 
 }
                 }
@@ -4736,7 +4737,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st45", 9) == 0)
                 {
 {
-return dev_storage + 504;
+return dev_storage + 505;
 
 }
                 }
@@ -4751,7 +4752,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st35", 9) == 0)
                 {
 {
-return dev_storage + 494;
+return dev_storage + 495;
 
 }
                 }
@@ -4766,7 +4767,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st25", 9) == 0)
                 {
 {
-return dev_storage + 484;
+return dev_storage + 485;
 
 }
                 }
@@ -4784,7 +4785,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st15", 9) == 0)
                     {
 {
-return dev_storage + 474;
+return dev_storage + 475;
 
 }
                     }
@@ -4799,7 +4800,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/sr15", 9) == 0)
                     {
 {
-return dev_storage + 458;
+return dev_storage + 459;
 
 }
                     }
@@ -4844,7 +4845,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/pty4", 9) == 0)
                 {
 {
-return dev_storage + 302;
+return dev_storage + 303;
 
 }
                 }
@@ -4859,7 +4860,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/nst4", 9) == 0)
                 {
 {
-return dev_storage + 172;
+return dev_storage + 173;
 
 }
                 }
@@ -4889,7 +4890,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/scd4", 9) == 0)
                 {
 {
-return dev_storage + 431;
+return dev_storage + 432;
 
 }
                 }
@@ -4904,7 +4905,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st94", 9) == 0)
                 {
 {
-return dev_storage + 553;
+return dev_storage + 554;
 
 }
                 }
@@ -4919,7 +4920,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st84", 9) == 0)
                 {
 {
-return dev_storage + 543;
+return dev_storage + 544;
 
 }
                 }
@@ -4934,7 +4935,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st74", 9) == 0)
                 {
 {
-return dev_storage + 533;
+return dev_storage + 534;
 
 }
                 }
@@ -4949,7 +4950,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st64", 9) == 0)
                 {
 {
-return dev_storage + 523;
+return dev_storage + 524;
 
 }
                 }
@@ -4964,7 +4965,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st54", 9) == 0)
                 {
 {
-return dev_storage + 513;
+return dev_storage + 514;
 
 }
                 }
@@ -4979,7 +4980,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st44", 9) == 0)
                 {
 {
-return dev_storage + 503;
+return dev_storage + 504;
 
 }
                 }
@@ -4994,7 +4995,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st34", 9) == 0)
                 {
 {
-return dev_storage + 493;
+return dev_storage + 494;
 
 }
                 }
@@ -5009,7 +5010,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st24", 9) == 0)
                 {
 {
-return dev_storage + 483;
+return dev_storage + 484;
 
 }
                 }
@@ -5027,7 +5028,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st14", 9) == 0)
                     {
 {
-return dev_storage + 473;
+return dev_storage + 474;
 
 }
                     }
@@ -5042,7 +5043,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/sr14", 9) == 0)
                     {
 {
-return dev_storage + 457;
+return dev_storage + 458;
 
 }
                     }
@@ -5087,7 +5088,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/pty3", 9) == 0)
                 {
 {
-return dev_storage + 301;
+return dev_storage + 302;
 
 }
                 }
@@ -5102,7 +5103,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/nst3", 9) == 0)
                 {
 {
-return dev_storage + 171;
+return dev_storage + 172;
 
 }
                 }
@@ -5132,7 +5133,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/scd3", 9) == 0)
                 {
 {
-return dev_storage + 430;
+return dev_storage + 431;
 
 }
                 }
@@ -5147,7 +5148,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st93", 9) == 0)
                 {
 {
-return dev_storage + 552;
+return dev_storage + 553;
 
 }
                 }
@@ -5162,7 +5163,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st83", 9) == 0)
                 {
 {
-return dev_storage + 542;
+return dev_storage + 543;
 
 }
                 }
@@ -5177,7 +5178,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st73", 9) == 0)
                 {
 {
-return dev_storage + 532;
+return dev_storage + 533;
 
 }
                 }
@@ -5192,7 +5193,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st63", 9) == 0)
                 {
 {
-return dev_storage + 522;
+return dev_storage + 523;
 
 }
                 }
@@ -5207,7 +5208,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st53", 9) == 0)
                 {
 {
-return dev_storage + 512;
+return dev_storage + 513;
 
 }
                 }
@@ -5222,7 +5223,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st43", 9) == 0)
                 {
 {
-return dev_storage + 502;
+return dev_storage + 503;
 
 }
                 }
@@ -5237,7 +5238,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st33", 9) == 0)
                 {
 {
-return dev_storage + 492;
+return dev_storage + 493;
 
 }
                 }
@@ -5252,7 +5253,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st23", 9) == 0)
                 {
 {
-return dev_storage + 482;
+return dev_storage + 483;
 
 }
                 }
@@ -5270,7 +5271,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st13", 9) == 0)
                     {
 {
-return dev_storage + 472;
+return dev_storage + 473;
 
 }
                     }
@@ -5285,7 +5286,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/sr13", 9) == 0)
                     {
 {
-return dev_storage + 456;
+return dev_storage + 457;
 
 }
                     }
@@ -5330,7 +5331,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/pty2", 9) == 0)
                 {
 {
-return dev_storage + 300;
+return dev_storage + 301;
 
 }
                 }
@@ -5345,7 +5346,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/nst2", 9) == 0)
                 {
 {
-return dev_storage + 170;
+return dev_storage + 171;
 
 }
                 }
@@ -5375,7 +5376,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/scd2", 9) == 0)
                 {
 {
-return dev_storage + 429;
+return dev_storage + 430;
 
 }
                 }
@@ -5390,7 +5391,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st92", 9) == 0)
                 {
 {
-return dev_storage + 551;
+return dev_storage + 552;
 
 }
                 }
@@ -5405,7 +5406,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st82", 9) == 0)
                 {
 {
-return dev_storage + 541;
+return dev_storage + 542;
 
 }
                 }
@@ -5420,7 +5421,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st72", 9) == 0)
                 {
 {
-return dev_storage + 531;
+return dev_storage + 532;
 
 }
                 }
@@ -5435,7 +5436,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st62", 9) == 0)
                 {
 {
-return dev_storage + 521;
+return dev_storage + 522;
 
 }
                 }
@@ -5450,7 +5451,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st52", 9) == 0)
                 {
 {
-return dev_storage + 511;
+return dev_storage + 512;
 
 }
                 }
@@ -5465,7 +5466,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st42", 9) == 0)
                 {
 {
-return dev_storage + 501;
+return dev_storage + 502;
 
 }
                 }
@@ -5480,7 +5481,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st32", 9) == 0)
                 {
 {
-return dev_storage + 491;
+return dev_storage + 492;
 
 }
                 }
@@ -5495,7 +5496,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st22", 9) == 0)
                 {
 {
-return dev_storage + 481;
+return dev_storage + 482;
 
 }
                 }
@@ -5513,7 +5514,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st12", 9) == 0)
                     {
 {
-return dev_storage + 471;
+return dev_storage + 472;
 
 }
                     }
@@ -5528,7 +5529,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/sr12", 9) == 0)
                     {
 {
-return dev_storage + 455;
+return dev_storage + 456;
 
 }
                     }
@@ -5573,7 +5574,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/pty1", 9) == 0)
                 {
 {
-return dev_storage + 299;
+return dev_storage + 300;
 
 }
                 }
@@ -5588,7 +5589,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/nst1", 9) == 0)
                 {
 {
-return dev_storage + 169;
+return dev_storage + 170;
 
 }
                 }
@@ -5618,7 +5619,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/scd1", 9) == 0)
                 {
 {
-return dev_storage + 428;
+return dev_storage + 429;
 
 }
                 }
@@ -5633,7 +5634,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st91", 9) == 0)
                 {
 {
-return dev_storage + 550;
+return dev_storage + 551;
 
 }
                 }
@@ -5648,7 +5649,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st81", 9) == 0)
                 {
 {
-return dev_storage + 540;
+return dev_storage + 541;
 
 }
                 }
@@ -5663,7 +5664,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st71", 9) == 0)
                 {
 {
-return dev_storage + 530;
+return dev_storage + 531;
 
 }
                 }
@@ -5678,7 +5679,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st61", 9) == 0)
                 {
 {
-return dev_storage + 520;
+return dev_storage + 521;
 
 }
                 }
@@ -5693,7 +5694,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st51", 9) == 0)
                 {
 {
-return dev_storage + 510;
+return dev_storage + 511;
 
 }
                 }
@@ -5708,7 +5709,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st41", 9) == 0)
                 {
 {
-return dev_storage + 500;
+return dev_storage + 501;
 
 }
                 }
@@ -5723,7 +5724,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st31", 9) == 0)
                 {
 {
-return dev_storage + 490;
+return dev_storage + 491;
 
 }
                 }
@@ -5738,7 +5739,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st21", 9) == 0)
                 {
 {
-return dev_storage + 480;
+return dev_storage + 481;
 
 }
                 }
@@ -5756,7 +5757,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st11", 9) == 0)
                     {
 {
-return dev_storage + 470;
+return dev_storage + 471;
 
 }
                     }
@@ -5771,7 +5772,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/sr11", 9) == 0)
                     {
 {
-return dev_storage + 454;
+return dev_storage + 455;
 
 }
                     }
@@ -5816,7 +5817,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/pty0", 9) == 0)
                 {
 {
-return dev_storage + 298;
+return dev_storage + 299;
 
 }
                 }
@@ -5831,7 +5832,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/nst0", 9) == 0)
                 {
 {
-return dev_storage + 168;
+return dev_storage + 169;
 
 }
                 }
@@ -5846,7 +5847,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/scd0", 9) == 0)
                 {
 {
-return dev_storage + 427;
+return dev_storage + 428;
 
 }
                 }
@@ -5861,7 +5862,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st90", 9) == 0)
                 {
 {
-return dev_storage + 549;
+return dev_storage + 550;
 
 }
                 }
@@ -5876,7 +5877,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st80", 9) == 0)
                 {
 {
-return dev_storage + 539;
+return dev_storage + 540;
 
 }
                 }
@@ -5891,7 +5892,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st70", 9) == 0)
                 {
 {
-return dev_storage + 529;
+return dev_storage + 530;
 
 }
                 }
@@ -5906,7 +5907,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st60", 9) == 0)
                 {
 {
-return dev_storage + 519;
+return dev_storage + 520;
 
 }
                 }
@@ -5921,7 +5922,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st50", 9) == 0)
                 {
 {
-return dev_storage + 509;
+return dev_storage + 510;
 
 }
                 }
@@ -5936,7 +5937,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st40", 9) == 0)
                 {
 {
-return dev_storage + 499;
+return dev_storage + 500;
 
 }
                 }
@@ -5951,7 +5952,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st30", 9) == 0)
                 {
 {
-return dev_storage + 489;
+return dev_storage + 490;
 
 }
                 }
@@ -5966,7 +5967,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st20", 9) == 0)
                 {
 {
-return dev_storage + 479;
+return dev_storage + 480;
 
 }
                 }
@@ -5984,7 +5985,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st10", 9) == 0)
                     {
 {
-return dev_storage + 469;
+return dev_storage + 470;
 
 }
                     }
@@ -5999,7 +6000,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/sr10", 9) == 0)
                     {
 {
-return dev_storage + 453;
+return dev_storage + 454;
 
 }
                     }
@@ -6212,7 +6213,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/stdin", 10) == 0)
                 {
 {
-return dev_storage + 588;
+return dev_storage + 589;
 
 }
                 }
@@ -6242,6 +6243,21 @@ return	NULL;
 {
 return	NULL;
 
+}
+            }
+        case 'e':
+          if (strncmp (KR_keyword, "/dev/mixer", 10) == 0)
+            {
+{
+return dev_storage + 168;
+
+}
+            }
+          else
+            {
+{
+return	NULL;
+
 }
             }
         case 'S':
@@ -6251,7 +6267,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/ttyS9", 10) == 0)
                 {
 {
-return dev_storage + 600;
+return dev_storage + 601;
 
 }
                 }
@@ -6266,7 +6282,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/ttyS8", 10) == 0)
                 {
 {
-return dev_storage + 599;
+return dev_storage + 600;
 
 }
                 }
@@ -6281,7 +6297,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/ttyS7", 10) == 0)
                 {
 {
-return dev_storage + 598;
+return dev_storage + 599;
 
 }
                 }
@@ -6296,7 +6312,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/ttyS6", 10) == 0)
                 {
 {
-return dev_storage + 597;
+return dev_storage + 598;
 
 }
                 }
@@ -6311,7 +6327,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/ttyS5", 10) == 0)
                 {
 {
-return dev_storage + 596;
+return dev_storage + 597;
 
 }
                 }
@@ -6326,7 +6342,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/ttyS4", 10) == 0)
                 {
 {
-return dev_storage + 595;
+return dev_storage + 596;
 
 }
                 }
@@ -6341,7 +6357,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/ttyS3", 10) == 0)
                 {
 {
-return dev_storage + 594;
+return dev_storage + 595;
 
 }
                 }
@@ -6356,7 +6372,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/ttyS2", 10) == 0)
                 {
 {
-return dev_storage + 593;
+return dev_storage + 594;
 
 }
                 }
@@ -6371,7 +6387,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/ttyS1", 10) == 0)
                 {
 {
-return dev_storage + 592;
+return dev_storage + 593;
 
 }
                 }
@@ -6386,7 +6402,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/ttyS0", 10) == 0)
                 {
 {
-return dev_storage + 591;
+return dev_storage + 592;
 
 }
                 }
@@ -6413,7 +6429,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty99", 10) == 0)
                     {
 {
-return dev_storage + 397;
+return dev_storage + 398;
 
 }
                     }
@@ -6428,7 +6444,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty98", 10) == 0)
                     {
 {
-return dev_storage + 396;
+return dev_storage + 397;
 
 }
                     }
@@ -6443,7 +6459,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty97", 10) == 0)
                     {
 {
-return dev_storage + 395;
+return dev_storage + 396;
 
 }
                     }
@@ -6458,7 +6474,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty96", 10) == 0)
                     {
 {
-return dev_storage + 394;
+return dev_storage + 395;
 
 }
                     }
@@ -6473,7 +6489,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty95", 10) == 0)
                     {
 {
-return dev_storage + 393;
+return dev_storage + 394;
 
 }
                     }
@@ -6488,7 +6504,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty94", 10) == 0)
                     {
 {
-return dev_storage + 392;
+return dev_storage + 393;
 
 }
                     }
@@ -6503,7 +6519,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty93", 10) == 0)
                     {
 {
-return dev_storage + 391;
+return dev_storage + 392;
 
 }
                     }
@@ -6518,7 +6534,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty92", 10) == 0)
                     {
 {
-return dev_storage + 390;
+return dev_storage + 391;
 
 }
                     }
@@ -6533,7 +6549,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty91", 10) == 0)
                     {
 {
-return dev_storage + 389;
+return dev_storage + 390;
 
 }
                     }
@@ -6548,7 +6564,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty90", 10) == 0)
                     {
 {
-return dev_storage + 388;
+return dev_storage + 389;
 
 }
                     }
@@ -6572,7 +6588,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst99", 10) == 0)
                     {
 {
-return dev_storage + 267;
+return dev_storage + 268;
 
 }
                     }
@@ -6587,7 +6603,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst98", 10) == 0)
                     {
 {
-return dev_storage + 266;
+return dev_storage + 267;
 
 }
                     }
@@ -6602,7 +6618,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst97", 10) == 0)
                     {
 {
-return dev_storage + 265;
+return dev_storage + 266;
 
 }
                     }
@@ -6617,7 +6633,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst96", 10) == 0)
                     {
 {
-return dev_storage + 264;
+return dev_storage + 265;
 
 }
                     }
@@ -6632,7 +6648,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst95", 10) == 0)
                     {
 {
-return dev_storage + 263;
+return dev_storage + 264;
 
 }
                     }
@@ -6647,7 +6663,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst94", 10) == 0)
                     {
 {
-return dev_storage + 262;
+return dev_storage + 263;
 
 }
                     }
@@ -6662,7 +6678,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst93", 10) == 0)
                     {
 {
-return dev_storage + 261;
+return dev_storage + 262;
 
 }
                     }
@@ -6677,7 +6693,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst92", 10) == 0)
                     {
 {
-return dev_storage + 260;
+return dev_storage + 261;
 
 }
                     }
@@ -6692,7 +6708,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst91", 10) == 0)
                     {
 {
-return dev_storage + 259;
+return dev_storage + 260;
 
 }
                     }
@@ -6707,7 +6723,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst90", 10) == 0)
                     {
 {
-return dev_storage + 258;
+return dev_storage + 259;
 
 }
                     }
@@ -6740,7 +6756,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty89", 10) == 0)
                     {
 {
-return dev_storage + 387;
+return dev_storage + 388;
 
 }
                     }
@@ -6755,7 +6771,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty88", 10) == 0)
                     {
 {
-return dev_storage + 386;
+return dev_storage + 387;
 
 }
                     }
@@ -6770,7 +6786,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty87", 10) == 0)
                     {
 {
-return dev_storage + 385;
+return dev_storage + 386;
 
 }
                     }
@@ -6785,7 +6801,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty86", 10) == 0)
                     {
 {
-return dev_storage + 384;
+return dev_storage + 385;
 
 }
                     }
@@ -6800,7 +6816,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty85", 10) == 0)
                     {
 {
-return dev_storage + 383;
+return dev_storage + 384;
 
 }
                     }
@@ -6815,7 +6831,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty84", 10) == 0)
                     {
 {
-return dev_storage + 382;
+return dev_storage + 383;
 
 }
                     }
@@ -6830,7 +6846,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty83", 10) == 0)
                     {
 {
-return dev_storage + 381;
+return dev_storage + 382;
 
 }
                     }
@@ -6845,7 +6861,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty82", 10) == 0)
                     {
 {
-return dev_storage + 380;
+return dev_storage + 381;
 
 }
                     }
@@ -6860,7 +6876,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty81", 10) == 0)
                     {
 {
-return dev_storage + 379;
+return dev_storage + 380;
 
 }
                     }
@@ -6875,7 +6891,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty80", 10) == 0)
                     {
 {
-return dev_storage + 378;
+return dev_storage + 379;
 
 }
                     }
@@ -6899,7 +6915,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst89", 10) == 0)
                     {
 {
-return dev_storage + 257;
+return dev_storage + 258;
 
 }
                     }
@@ -6914,7 +6930,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst88", 10) == 0)
                     {
 {
-return dev_storage + 256;
+return dev_storage + 257;
 
 }
                     }
@@ -6929,7 +6945,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst87", 10) == 0)
                     {
 {
-return dev_storage + 255;
+return dev_storage + 256;
 
 }
                     }
@@ -6944,7 +6960,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst86", 10) == 0)
                     {
 {
-return dev_storage + 254;
+return dev_storage + 255;
 
 }
                     }
@@ -6959,7 +6975,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst85", 10) == 0)
                     {
 {
-return dev_storage + 253;
+return dev_storage + 254;
 
 }
                     }
@@ -6974,7 +6990,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst84", 10) == 0)
                     {
 {
-return dev_storage + 252;
+return dev_storage + 253;
 
 }
                     }
@@ -6989,7 +7005,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst83", 10) == 0)
                     {
 {
-return dev_storage + 251;
+return dev_storage + 252;
 
 }
                     }
@@ -7004,7 +7020,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst82", 10) == 0)
                     {
 {
-return dev_storage + 250;
+return dev_storage + 251;
 
 }
                     }
@@ -7019,7 +7035,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst81", 10) == 0)
                     {
 {
-return dev_storage + 249;
+return dev_storage + 250;
 
 }
                     }
@@ -7034,7 +7050,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst80", 10) == 0)
                     {
 {
-return dev_storage + 248;
+return dev_storage + 249;
 
 }
                     }
@@ -7067,7 +7083,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty79", 10) == 0)
                     {
 {
-return dev_storage + 377;
+return dev_storage + 378;
 
 }
                     }
@@ -7082,7 +7098,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty78", 10) == 0)
                     {
 {
-return dev_storage + 376;
+return dev_storage + 377;
 
 }
                     }
@@ -7097,7 +7113,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty77", 10) == 0)
                     {
 {
-return dev_storage + 375;
+return dev_storage + 376;
 
 }
                     }
@@ -7112,7 +7128,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty76", 10) == 0)
                     {
 {
-return dev_storage + 374;
+return dev_storage + 375;
 
 }
                     }
@@ -7127,7 +7143,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty75", 10) == 0)
                     {
 {
-return dev_storage + 373;
+return dev_storage + 374;
 
 }
                     }
@@ -7142,7 +7158,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty74", 10) == 0)
                     {
 {
-return dev_storage + 372;
+return dev_storage + 373;
 
 }
                     }
@@ -7157,7 +7173,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty73", 10) == 0)
                     {
 {
-return dev_storage + 371;
+return dev_storage + 372;
 
 }
                     }
@@ -7172,7 +7188,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty72", 10) == 0)
                     {
 {
-return dev_storage + 370;
+return dev_storage + 371;
 
 }
                     }
@@ -7187,7 +7203,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty71", 10) == 0)
                     {
 {
-return dev_storage + 369;
+return dev_storage + 370;
 
 }
                     }
@@ -7202,7 +7218,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty70", 10) == 0)
                     {
 {
-return dev_storage + 368;
+return dev_storage + 369;
 
 }
                     }
@@ -7226,7 +7242,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst79", 10) == 0)
                     {
 {
-return dev_storage + 247;
+return dev_storage + 248;
 
 }
                     }
@@ -7241,7 +7257,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst78", 10) == 0)
                     {
 {
-return dev_storage + 246;
+return dev_storage + 247;
 
 }
                     }
@@ -7256,7 +7272,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst77", 10) == 0)
                     {
 {
-return dev_storage + 245;
+return dev_storage + 246;
 
 }
                     }
@@ -7271,7 +7287,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst76", 10) == 0)
                     {
 {
-return dev_storage + 244;
+return dev_storage + 245;
 
 }
                     }
@@ -7286,7 +7302,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst75", 10) == 0)
                     {
 {
-return dev_storage + 243;
+return dev_storage + 244;
 
 }
                     }
@@ -7301,7 +7317,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst74", 10) == 0)
                     {
 {
-return dev_storage + 242;
+return dev_storage + 243;
 
 }
                     }
@@ -7316,7 +7332,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst73", 10) == 0)
                     {
 {
-return dev_storage + 241;
+return dev_storage + 242;
 
 }
                     }
@@ -7331,7 +7347,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst72", 10) == 0)
                     {
 {
-return dev_storage + 240;
+return dev_storage + 241;
 
 }
                     }
@@ -7346,7 +7362,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst71", 10) == 0)
                     {
 {
-return dev_storage + 239;
+return dev_storage + 240;
 
 }
                     }
@@ -7361,7 +7377,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst70", 10) == 0)
                     {
 {
-return dev_storage + 238;
+return dev_storage + 239;
 
 }
                     }
@@ -7394,7 +7410,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty69", 10) == 0)
                     {
 {
-return dev_storage + 367;
+return dev_storage + 368;
 
 }
                     }
@@ -7409,7 +7425,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty68", 10) == 0)
                     {
 {
-return dev_storage + 366;
+return dev_storage + 367;
 
 }
                     }
@@ -7424,7 +7440,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty67", 10) == 0)
                     {
 {
-return dev_storage + 365;
+return dev_storage + 366;
 
 }
                     }
@@ -7439,7 +7455,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty66", 10) == 0)
                     {
 {
-return dev_storage + 364;
+return dev_storage + 365;
 
 }
                     }
@@ -7454,7 +7470,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty65", 10) == 0)
                     {
 {
-return dev_storage + 363;
+return dev_storage + 364;
 
 }
                     }
@@ -7469,7 +7485,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty64", 10) == 0)
                     {
 {
-return dev_storage + 362;
+return dev_storage + 363;
 
 }
                     }
@@ -7484,7 +7500,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty63", 10) == 0)
                     {
 {
-return dev_storage + 361;
+return dev_storage + 362;
 
 }
                     }
@@ -7499,7 +7515,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty62", 10) == 0)
                     {
 {
-return dev_storage + 360;
+return dev_storage + 361;
 
 }
                     }
@@ -7514,7 +7530,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty61", 10) == 0)
                     {
 {
-return dev_storage + 359;
+return dev_storage + 360;
 
 }
                     }
@@ -7529,7 +7545,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty60", 10) == 0)
                     {
 {
-return dev_storage + 358;
+return dev_storage + 359;
 
 }
                     }
@@ -7553,7 +7569,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst69", 10) == 0)
                     {
 {
-return dev_storage + 237;
+return dev_storage + 238;
 
 }
                     }
@@ -7568,7 +7584,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst68", 10) == 0)
                     {
 {
-return dev_storage + 236;
+return dev_storage + 237;
 
 }
                     }
@@ -7583,7 +7599,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst67", 10) == 0)
                     {
 {
-return dev_storage + 235;
+return dev_storage + 236;
 
 }
                     }
@@ -7598,7 +7614,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst66", 10) == 0)
                     {
 {
-return dev_storage + 234;
+return dev_storage + 235;
 
 }
                     }
@@ -7613,7 +7629,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst65", 10) == 0)
                     {
 {
-return dev_storage + 233;
+return dev_storage + 234;
 
 }
                     }
@@ -7628,7 +7644,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst64", 10) == 0)
                     {
 {
-return dev_storage + 232;
+return dev_storage + 233;
 
 }
                     }
@@ -7643,7 +7659,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst63", 10) == 0)
                     {
 {
-return dev_storage + 231;
+return dev_storage + 232;
 
 }
                     }
@@ -7658,7 +7674,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst62", 10) == 0)
                     {
 {
-return dev_storage + 230;
+return dev_storage + 231;
 
 }
                     }
@@ -7673,7 +7689,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst61", 10) == 0)
                     {
 {
-return dev_storage + 229;
+return dev_storage + 230;
 
 }
                     }
@@ -7688,7 +7704,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst60", 10) == 0)
                     {
 {
-return dev_storage + 228;
+return dev_storage + 229;
 
 }
                     }
@@ -7721,7 +7737,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty59", 10) == 0)
                     {
 {
-return dev_storage + 357;
+return dev_storage + 358;
 
 }
                     }
@@ -7736,7 +7752,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty58", 10) == 0)
                     {
 {
-return dev_storage + 356;
+return dev_storage + 357;
 
 }
                     }
@@ -7751,7 +7767,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty57", 10) == 0)
                     {
 {
-return dev_storage + 355;
+return dev_storage + 356;
 
 }
                     }
@@ -7766,7 +7782,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty56", 10) == 0)
                     {
 {
-return dev_storage + 354;
+return dev_storage + 355;
 
 }
                     }
@@ -7781,7 +7797,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty55", 10) == 0)
                     {
 {
-return dev_storage + 353;
+return dev_storage + 354;
 
 }
                     }
@@ -7796,7 +7812,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty54", 10) == 0)
                     {
 {
-return dev_storage + 352;
+return dev_storage + 353;
 
 }
                     }
@@ -7811,7 +7827,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty53", 10) == 0)
                     {
 {
-return dev_storage + 351;
+return dev_storage + 352;
 
 }
                     }
@@ -7826,7 +7842,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty52", 10) == 0)
                     {
 {
-return dev_storage + 350;
+return dev_storage + 351;
 
 }
                     }
@@ -7841,7 +7857,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty51", 10) == 0)
                     {
 {
-return dev_storage + 349;
+return dev_storage + 350;
 
 }
                     }
@@ -7856,7 +7872,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty50", 10) == 0)
                     {
 {
-return dev_storage + 348;
+return dev_storage + 349;
 
 }
                     }
@@ -7880,7 +7896,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst59", 10) == 0)
                     {
 {
-return dev_storage + 227;
+return dev_storage + 228;
 
 }
                     }
@@ -7895,7 +7911,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst58", 10) == 0)
                     {
 {
-return dev_storage + 226;
+return dev_storage + 227;
 
 }
                     }
@@ -7910,7 +7926,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst57", 10) == 0)
                     {
 {
-return dev_storage + 225;
+return dev_storage + 226;
 
 }
                     }
@@ -7925,7 +7941,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst56", 10) == 0)
                     {
 {
-return dev_storage + 224;
+return dev_storage + 225;
 
 }
                     }
@@ -7940,7 +7956,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst55", 10) == 0)
                     {
 {
-return dev_storage + 223;
+return dev_storage + 224;
 
 }
                     }
@@ -7955,7 +7971,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst54", 10) == 0)
                     {
 {
-return dev_storage + 222;
+return dev_storage + 223;
 
 }
                     }
@@ -7970,7 +7986,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst53", 10) == 0)
                     {
 {
-return dev_storage + 221;
+return dev_storage + 222;
 
 }
                     }
@@ -7985,7 +8001,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst52", 10) == 0)
                     {
 {
-return dev_storage + 220;
+return dev_storage + 221;
 
 }
                     }
@@ -8000,7 +8016,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst51", 10) == 0)
                     {
 {
-return dev_storage + 219;
+return dev_storage + 220;
 
 }
                     }
@@ -8015,7 +8031,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst50", 10) == 0)
                     {
 {
-return dev_storage + 218;
+return dev_storage + 219;
 
 }
                     }
@@ -8048,7 +8064,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty49", 10) == 0)
                     {
 {
-return dev_storage + 347;
+return dev_storage + 348;
 
 }
                     }
@@ -8063,7 +8079,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty48", 10) == 0)
                     {
 {
-return dev_storage + 346;
+return dev_storage + 347;
 
 }
                     }
@@ -8078,7 +8094,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty47", 10) == 0)
                     {
 {
-return dev_storage + 345;
+return dev_storage + 346;
 
 }
                     }
@@ -8093,7 +8109,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty46", 10) == 0)
                     {
 {
-return dev_storage + 344;
+return dev_storage + 345;
 
 }
                     }
@@ -8108,7 +8124,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty45", 10) == 0)
                     {
 {
-return dev_storage + 343;
+return dev_storage + 344;
 
 }
                     }
@@ -8123,7 +8139,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty44", 10) == 0)
                     {
 {
-return dev_storage + 342;
+return dev_storage + 343;
 
 }
                     }
@@ -8138,7 +8154,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty43", 10) == 0)
                     {
 {
-return dev_storage + 341;
+return dev_storage + 342;
 
 }
                     }
@@ -8153,7 +8169,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty42", 10) == 0)
                     {
 {
-return dev_storage + 340;
+return dev_storage + 341;
 
 }
                     }
@@ -8168,7 +8184,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty41", 10) == 0)
                     {
 {
-return dev_storage + 339;
+return dev_storage + 340;
 
 }
                     }
@@ -8183,7 +8199,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty40", 10) == 0)
                     {
 {
-return dev_storage + 338;
+return dev_storage + 339;
 
 }
                     }
@@ -8207,7 +8223,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst49", 10) == 0)
                     {
 {
-return dev_storage + 217;
+return dev_storage + 218;
 
 }
                     }
@@ -8222,7 +8238,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst48", 10) == 0)
                     {
 {
-return dev_storage + 216;
+return dev_storage + 217;
 
 }
                     }
@@ -8237,7 +8253,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst47", 10) == 0)
                     {
 {
-return dev_storage + 215;
+return dev_storage + 216;
 
 }
                     }
@@ -8252,7 +8268,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst46", 10) == 0)
                     {
 {
-return dev_storage + 214;
+return dev_storage + 215;
 
 }
                     }
@@ -8267,7 +8283,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst45", 10) == 0)
                     {
 {
-return dev_storage + 213;
+return dev_storage + 214;
 
 }
                     }
@@ -8282,7 +8298,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst44", 10) == 0)
                     {
 {
-return dev_storage + 212;
+return dev_storage + 213;
 
 }
                     }
@@ -8297,7 +8313,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst43", 10) == 0)
                     {
 {
-return dev_storage + 211;
+return dev_storage + 212;
 
 }
                     }
@@ -8312,7 +8328,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst42", 10) == 0)
                     {
 {
-return dev_storage + 210;
+return dev_storage + 211;
 
 }
                     }
@@ -8327,7 +8343,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst41", 10) == 0)
                     {
 {
-return dev_storage + 209;
+return dev_storage + 210;
 
 }
                     }
@@ -8342,7 +8358,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst40", 10) == 0)
                     {
 {
-return dev_storage + 208;
+return dev_storage + 209;
 
 }
                     }
@@ -8375,7 +8391,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty39", 10) == 0)
                     {
 {
-return dev_storage + 337;
+return dev_storage + 338;
 
 }
                     }
@@ -8390,7 +8406,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty38", 10) == 0)
                     {
 {
-return dev_storage + 336;
+return dev_storage + 337;
 
 }
                     }
@@ -8405,7 +8421,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty37", 10) == 0)
                     {
 {
-return dev_storage + 335;
+return dev_storage + 336;
 
 }
                     }
@@ -8420,7 +8436,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty36", 10) == 0)
                     {
 {
-return dev_storage + 334;
+return dev_storage + 335;
 
 }
                     }
@@ -8435,7 +8451,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty35", 10) == 0)
                     {
 {
-return dev_storage + 333;
+return dev_storage + 334;
 
 }
                     }
@@ -8450,7 +8466,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty34", 10) == 0)
                     {
 {
-return dev_storage + 332;
+return dev_storage + 333;
 
 }
                     }
@@ -8465,7 +8481,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty33", 10) == 0)
                     {
 {
-return dev_storage + 331;
+return dev_storage + 332;
 
 }
                     }
@@ -8480,7 +8496,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty32", 10) == 0)
                     {
 {
-return dev_storage + 330;
+return dev_storage + 331;
 
 }
                     }
@@ -8495,7 +8511,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty31", 10) == 0)
                     {
 {
-return dev_storage + 329;
+return dev_storage + 330;
 
 }
                     }
@@ -8510,7 +8526,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty30", 10) == 0)
                     {
 {
-return dev_storage + 328;
+return dev_storage + 329;
 
 }
                     }
@@ -8534,7 +8550,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst39", 10) == 0)
                     {
 {
-return dev_storage + 207;
+return dev_storage + 208;
 
 }
                     }
@@ -8549,7 +8565,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst38", 10) == 0)
                     {
 {
-return dev_storage + 206;
+return dev_storage + 207;
 
 }
                     }
@@ -8564,7 +8580,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst37", 10) == 0)
                     {
 {
-return dev_storage + 205;
+return dev_storage + 206;
 
 }
                     }
@@ -8579,7 +8595,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst36", 10) == 0)
                     {
 {
-return dev_storage + 204;
+return dev_storage + 205;
 
 }
                     }
@@ -8594,7 +8610,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst35", 10) == 0)
                     {
 {
-return dev_storage + 203;
+return dev_storage + 204;
 
 }
                     }
@@ -8609,7 +8625,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst34", 10) == 0)
                     {
 {
-return dev_storage + 202;
+return dev_storage + 203;
 
 }
                     }
@@ -8624,7 +8640,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst33", 10) == 0)
                     {
 {
-return dev_storage + 201;
+return dev_storage + 202;
 
 }
                     }
@@ -8639,7 +8655,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst32", 10) == 0)
                     {
 {
-return dev_storage + 200;
+return dev_storage + 201;
 
 }
                     }
@@ -8654,7 +8670,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst31", 10) == 0)
                     {
 {
-return dev_storage + 199;
+return dev_storage + 200;
 
 }
                     }
@@ -8669,7 +8685,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst30", 10) == 0)
                     {
 {
-return dev_storage + 198;
+return dev_storage + 199;
 
 }
                     }
@@ -8702,7 +8718,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st127", 10) == 0)
                     {
 {
-return dev_storage + 586;
+return dev_storage + 587;
 
 }
                     }
@@ -8717,7 +8733,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st126", 10) == 0)
                     {
 {
-return dev_storage + 585;
+return dev_storage + 586;
 
 }
                     }
@@ -8732,7 +8748,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st125", 10) == 0)
                     {
 {
-return dev_storage + 584;
+return dev_storage + 585;
 
 }
                     }
@@ -8747,7 +8763,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st124", 10) == 0)
                     {
 {
-return dev_storage + 583;
+return dev_storage + 584;
 
 }
                     }
@@ -8762,7 +8778,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st123", 10) == 0)
                     {
 {
-return dev_storage + 582;
+return dev_storage + 583;
 
 }
                     }
@@ -8777,7 +8793,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st122", 10) == 0)
                     {
 {
-return dev_storage + 581;
+return dev_storage + 582;
 
 }
                     }
@@ -8792,7 +8808,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st121", 10) == 0)
                     {
 {
-return dev_storage + 580;
+return dev_storage + 581;
 
 }
                     }
@@ -8807,7 +8823,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st120", 10) == 0)
                     {
 {
-return dev_storage + 579;
+return dev_storage + 580;
 
 }
                     }
@@ -8831,7 +8847,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty29", 10) == 0)
                     {
 {
-return dev_storage + 327;
+return dev_storage + 328;
 
 }
                     }
@@ -8846,7 +8862,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty28", 10) == 0)
                     {
 {
-return dev_storage + 326;
+return dev_storage + 327;
 
 }
                     }
@@ -8861,7 +8877,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty27", 10) == 0)
                     {
 {
-return dev_storage + 325;
+return dev_storage + 326;
 
 }
                     }
@@ -8876,7 +8892,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty26", 10) == 0)
                     {
 {
-return dev_storage + 324;
+return dev_storage + 325;
 
 }
                     }
@@ -8891,7 +8907,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty25", 10) == 0)
                     {
 {
-return dev_storage + 323;
+return dev_storage + 324;
 
 }
                     }
@@ -8906,7 +8922,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty24", 10) == 0)
                     {
 {
-return dev_storage + 322;
+return dev_storage + 323;
 
 }
                     }
@@ -8921,7 +8937,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty23", 10) == 0)
                     {
 {
-return dev_storage + 321;
+return dev_storage + 322;
 
 }
                     }
@@ -8936,7 +8952,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty22", 10) == 0)
                     {
 {
-return dev_storage + 320;
+return dev_storage + 321;
 
 }
                     }
@@ -8951,7 +8967,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty21", 10) == 0)
                     {
 {
-return dev_storage + 319;
+return dev_storage + 320;
 
 }
                     }
@@ -8966,7 +8982,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty20", 10) == 0)
                     {
 {
-return dev_storage + 318;
+return dev_storage + 319;
 
 }
                     }
@@ -8990,7 +9006,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst29", 10) == 0)
                     {
 {
-return dev_storage + 197;
+return dev_storage + 198;
 
 }
                     }
@@ -9005,7 +9021,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst28", 10) == 0)
                     {
 {
-return dev_storage + 196;
+return dev_storage + 197;
 
 }
                     }
@@ -9020,7 +9036,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst27", 10) == 0)
                     {
 {
-return dev_storage + 195;
+return dev_storage + 196;
 
 }
                     }
@@ -9035,7 +9051,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst26", 10) == 0)
                     {
 {
-return dev_storage + 194;
+return dev_storage + 195;
 
 }
                     }
@@ -9050,7 +9066,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst25", 10) == 0)
                     {
 {
-return dev_storage + 193;
+return dev_storage + 194;
 
 }
                     }
@@ -9065,7 +9081,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst24", 10) == 0)
                     {
 {
-return dev_storage + 192;
+return dev_storage + 193;
 
 }
                     }
@@ -9080,7 +9096,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst23", 10) == 0)
                     {
 {
-return dev_storage + 191;
+return dev_storage + 192;
 
 }
                     }
@@ -9095,7 +9111,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst22", 10) == 0)
                     {
 {
-return dev_storage + 190;
+return dev_storage + 191;
 
 }
                     }
@@ -9110,7 +9126,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst21", 10) == 0)
                     {
 {
-return dev_storage + 189;
+return dev_storage + 190;
 
 }
                     }
@@ -9125,7 +9141,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst20", 10) == 0)
                     {
 {
-return dev_storage + 188;
+return dev_storage + 189;
 
 }
                     }
@@ -9158,7 +9174,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty19", 10) == 0)
                     {
 {
-return dev_storage + 317;
+return dev_storage + 318;
 
 }
                     }
@@ -9173,7 +9189,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty18", 10) == 0)
                     {
 {
-return dev_storage + 316;
+return dev_storage + 317;
 
 }
                     }
@@ -9188,7 +9204,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty17", 10) == 0)
                     {
 {
-return dev_storage + 315;
+return dev_storage + 316;
 
 }
                     }
@@ -9203,7 +9219,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty16", 10) == 0)
                     {
 {
-return dev_storage + 314;
+return dev_storage + 315;
 
 }
                     }
@@ -9218,7 +9234,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty15", 10) == 0)
                     {
 {
-return dev_storage + 313;
+return dev_storage + 314;
 
 }
                     }
@@ -9233,7 +9249,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty14", 10) == 0)
                     {
 {
-return dev_storage + 312;
+return dev_storage + 313;
 
 }
                     }
@@ -9248,7 +9264,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty13", 10) == 0)
                     {
 {
-return dev_storage + 311;
+return dev_storage + 312;
 
 }
                     }
@@ -9263,7 +9279,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty12", 10) == 0)
                     {
 {
-return dev_storage + 310;
+return dev_storage + 311;
 
 }
                     }
@@ -9278,7 +9294,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty11", 10) == 0)
                     {
 {
-return dev_storage + 309;
+return dev_storage + 310;
 
 }
                     }
@@ -9293,7 +9309,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty10", 10) == 0)
                     {
 {
-return dev_storage + 308;
+return dev_storage + 309;
 
 }
                     }
@@ -9317,7 +9333,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst19", 10) == 0)
                     {
 {
-return dev_storage + 187;
+return dev_storage + 188;
 
 }
                     }
@@ -9332,7 +9348,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst18", 10) == 0)
                     {
 {
-return dev_storage + 186;
+return dev_storage + 187;
 
 }
                     }
@@ -9347,7 +9363,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst17", 10) == 0)
                     {
 {
-return dev_storage + 185;
+return dev_storage + 186;
 
 }
                     }
@@ -9362,7 +9378,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst16", 10) == 0)
                     {
 {
-return dev_storage + 184;
+return dev_storage + 185;
 
 }
                     }
@@ -9377,7 +9393,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst15", 10) == 0)
                     {
 {
-return dev_storage + 183;
+return dev_storage + 184;
 
 }
                     }
@@ -9392,7 +9408,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst14", 10) == 0)
                     {
 {
-return dev_storage + 182;
+return dev_storage + 183;
 
 }
                     }
@@ -9407,7 +9423,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst13", 10) == 0)
                     {
 {
-return dev_storage + 181;
+return dev_storage + 182;
 
 }
                     }
@@ -9422,7 +9438,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst12", 10) == 0)
                     {
 {
-return dev_storage + 180;
+return dev_storage + 181;
 
 }
                     }
@@ -9437,7 +9453,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst11", 10) == 0)
                     {
 {
-return dev_storage + 179;
+return dev_storage + 180;
 
 }
                     }
@@ -9452,7 +9468,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst10", 10) == 0)
                     {
 {
-return dev_storage + 178;
+return dev_storage + 179;
 
 }
                     }
@@ -9590,7 +9606,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/scd15", 10) == 0)
                     {
 {
-return dev_storage + 442;
+return dev_storage + 443;
 
 }
                     }
@@ -9605,7 +9621,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/scd14", 10) == 0)
                     {
 {
-return dev_storage + 441;
+return dev_storage + 442;
 
 }
                     }
@@ -9620,7 +9636,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/scd13", 10) == 0)
                     {
 {
-return dev_storage + 440;
+return dev_storage + 441;
 
 }
                     }
@@ -9635,7 +9651,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/scd12", 10) == 0)
                     {
 {
-return dev_storage + 439;
+return dev_storage + 440;
 
 }
                     }
@@ -9650,7 +9666,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/scd11", 10) == 0)
                     {
 {
-return dev_storage + 438;
+return dev_storage + 439;
 
 }
                     }
@@ -9665,7 +9681,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/scd10", 10) == 0)
                     {
 {
-return dev_storage + 437;
+return dev_storage + 438;
 
 }
                     }
@@ -9689,7 +9705,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st119", 10) == 0)
                     {
 {
-return dev_storage + 578;
+return dev_storage + 579;
 
 }
                     }
@@ -9704,7 +9720,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st118", 10) == 0)
                     {
 {
-return dev_storage + 577;
+return dev_storage + 578;
 
 }
                     }
@@ -9719,7 +9735,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st117", 10) == 0)
                     {
 {
-return dev_storage + 576;
+return dev_storage + 577;
 
 }
                     }
@@ -9734,7 +9750,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st116", 10) == 0)
                     {
 {
-return dev_storage + 575;
+return dev_storage + 576;
 
 }
                     }
@@ -9749,7 +9765,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st115", 10) == 0)
                     {
 {
-return dev_storage + 574;
+return dev_storage + 575;
 
 }
                     }
@@ -9764,7 +9780,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st114", 10) == 0)
                     {
 {
-return dev_storage + 573;
+return dev_storage + 574;
 
 }
                     }
@@ -9779,7 +9795,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st113", 10) == 0)
                     {
 {
-return dev_storage + 572;
+return dev_storage + 573;
 
 }
                     }
@@ -9794,7 +9810,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st112", 10) == 0)
                     {
 {
-return dev_storage + 571;
+return dev_storage + 572;
 
 }
                     }
@@ -9809,7 +9825,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st111", 10) == 0)
                     {
 {
-return dev_storage + 570;
+return dev_storage + 571;
 
 }
                     }
@@ -9824,7 +9840,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/st110", 10) == 0)
                     {
 {
-return dev_storage + 569;
+return dev_storage + 570;
 
 }
                     }
@@ -9854,7 +9870,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st109", 10) == 0)
                 {
 {
-return dev_storage + 568;
+return dev_storage + 569;
 
 }
                 }
@@ -9869,7 +9885,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st108", 10) == 0)
                 {
 {
-return dev_storage + 567;
+return dev_storage + 568;
 
 }
                 }
@@ -9884,7 +9900,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st107", 10) == 0)
                 {
 {
-return dev_storage + 566;
+return dev_storage + 567;
 
 }
                 }
@@ -9899,7 +9915,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st106", 10) == 0)
                 {
 {
-return dev_storage + 565;
+return dev_storage + 566;
 
 }
                 }
@@ -9914,7 +9930,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st105", 10) == 0)
                 {
 {
-return dev_storage + 564;
+return dev_storage + 565;
 
 }
                 }
@@ -9929,7 +9945,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st104", 10) == 0)
                 {
 {
-return dev_storage + 563;
+return dev_storage + 564;
 
 }
                 }
@@ -9944,7 +9960,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st103", 10) == 0)
                 {
 {
-return dev_storage + 562;
+return dev_storage + 563;
 
 }
                 }
@@ -9959,7 +9975,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st102", 10) == 0)
                 {
 {
-return dev_storage + 561;
+return dev_storage + 562;
 
 }
                 }
@@ -9974,7 +9990,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st101", 10) == 0)
                 {
 {
-return dev_storage + 560;
+return dev_storage + 561;
 
 }
                 }
@@ -9989,7 +10005,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/st100", 10) == 0)
                 {
 {
-return dev_storage + 559;
+return dev_storage + 560;
 
 }
                 }
@@ -10022,7 +10038,7 @@ return	NULL;
               if (strncmp (KR_keyword, "/dev/stdout", 11) == 0)
                 {
 {
-return dev_storage + 589;
+return dev_storage + 590;
 
 }
                 }
@@ -10058,7 +10074,7 @@ return	NULL;
           if (strncmp (KR_keyword, "/dev/stderr", 11) == 0)
             {
 {
-return dev_storage + 587;
+return dev_storage + 588;
 
 }
             }
@@ -10073,7 +10089,7 @@ return	NULL;
           if (strncmp (KR_keyword, "/dev/random", 11) == 0)
             {
 {
-return dev_storage + 426;
+return dev_storage + 427;
 
 }
             }
@@ -10094,7 +10110,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS99", 11) == 0)
                     {
 {
-return dev_storage + 690;
+return dev_storage + 691;
 
 }
                     }
@@ -10109,7 +10125,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS98", 11) == 0)
                     {
 {
-return dev_storage + 689;
+return dev_storage + 690;
 
 }
                     }
@@ -10124,7 +10140,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS97", 11) == 0)
                     {
 {
-return dev_storage + 688;
+return dev_storage + 689;
 
 }
                     }
@@ -10139,7 +10155,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS96", 11) == 0)
                     {
 {
-return dev_storage + 687;
+return dev_storage + 688;
 
 }
                     }
@@ -10154,7 +10170,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS95", 11) == 0)
                     {
 {
-return dev_storage + 686;
+return dev_storage + 687;
 
 }
                     }
@@ -10169,7 +10185,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS94", 11) == 0)
                     {
 {
-return dev_storage + 685;
+return dev_storage + 686;
 
 }
                     }
@@ -10184,7 +10200,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS93", 11) == 0)
                     {
 {
-return dev_storage + 684;
+return dev_storage + 685;
 
 }
                     }
@@ -10199,7 +10215,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS92", 11) == 0)
                     {
 {
-return dev_storage + 683;
+return dev_storage + 684;
 
 }
                     }
@@ -10214,7 +10230,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS91", 11) == 0)
                     {
 {
-return dev_storage + 682;
+return dev_storage + 683;
 
 }
                     }
@@ -10229,7 +10245,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS90", 11) == 0)
                     {
 {
-return dev_storage + 681;
+return dev_storage + 682;
 
 }
                     }
@@ -10421,7 +10437,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS89", 11) == 0)
                     {
 {
-return dev_storage + 680;
+return dev_storage + 681;
 
 }
                     }
@@ -10436,7 +10452,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS88", 11) == 0)
                     {
 {
-return dev_storage + 679;
+return dev_storage + 680;
 
 }
                     }
@@ -10451,7 +10467,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS87", 11) == 0)
                     {
 {
-return dev_storage + 678;
+return dev_storage + 679;
 
 }
                     }
@@ -10466,7 +10482,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS86", 11) == 0)
                     {
 {
-return dev_storage + 677;
+return dev_storage + 678;
 
 }
                     }
@@ -10481,7 +10497,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS85", 11) == 0)
                     {
 {
-return dev_storage + 676;
+return dev_storage + 677;
 
 }
                     }
@@ -10496,7 +10512,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS84", 11) == 0)
                     {
 {
-return dev_storage + 675;
+return dev_storage + 676;
 
 }
                     }
@@ -10511,7 +10527,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS83", 11) == 0)
                     {
 {
-return dev_storage + 674;
+return dev_storage + 675;
 
 }
                     }
@@ -10526,7 +10542,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS82", 11) == 0)
                     {
 {
-return dev_storage + 673;
+return dev_storage + 674;
 
 }
                     }
@@ -10541,7 +10557,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS81", 11) == 0)
                     {
 {
-return dev_storage + 672;
+return dev_storage + 673;
 
 }
                     }
@@ -10556,7 +10572,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS80", 11) == 0)
                     {
 {
-return dev_storage + 671;
+return dev_storage + 672;
 
 }
                     }
@@ -10748,7 +10764,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS79", 11) == 0)
                     {
 {
-return dev_storage + 670;
+return dev_storage + 671;
 
 }
                     }
@@ -10763,7 +10779,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS78", 11) == 0)
                     {
 {
-return dev_storage + 669;
+return dev_storage + 670;
 
 }
                     }
@@ -10778,7 +10794,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS77", 11) == 0)
                     {
 {
-return dev_storage + 668;
+return dev_storage + 669;
 
 }
                     }
@@ -10793,7 +10809,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS76", 11) == 0)
                     {
 {
-return dev_storage + 667;
+return dev_storage + 668;
 
 }
                     }
@@ -10808,7 +10824,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS75", 11) == 0)
                     {
 {
-return dev_storage + 666;
+return dev_storage + 667;
 
 }
                     }
@@ -10823,7 +10839,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS74", 11) == 0)
                     {
 {
-return dev_storage + 665;
+return dev_storage + 666;
 
 }
                     }
@@ -10838,7 +10854,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS73", 11) == 0)
                     {
 {
-return dev_storage + 664;
+return dev_storage + 665;
 
 }
                     }
@@ -10853,7 +10869,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS72", 11) == 0)
                     {
 {
-return dev_storage + 663;
+return dev_storage + 664;
 
 }
                     }
@@ -10868,7 +10884,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS71", 11) == 0)
                     {
 {
-return dev_storage + 662;
+return dev_storage + 663;
 
 }
                     }
@@ -10883,7 +10899,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS70", 11) == 0)
                     {
 {
-return dev_storage + 661;
+return dev_storage + 662;
 
 }
                     }
@@ -11075,7 +11091,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS69", 11) == 0)
                     {
 {
-return dev_storage + 660;
+return dev_storage + 661;
 
 }
                     }
@@ -11090,7 +11106,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS68", 11) == 0)
                     {
 {
-return dev_storage + 659;
+return dev_storage + 660;
 
 }
                     }
@@ -11105,7 +11121,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS67", 11) == 0)
                     {
 {
-return dev_storage + 658;
+return dev_storage + 659;
 
 }
                     }
@@ -11120,7 +11136,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS66", 11) == 0)
                     {
 {
-return dev_storage + 657;
+return dev_storage + 658;
 
 }
                     }
@@ -11135,7 +11151,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS65", 11) == 0)
                     {
 {
-return dev_storage + 656;
+return dev_storage + 657;
 
 }
                     }
@@ -11150,7 +11166,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS64", 11) == 0)
                     {
 {
-return dev_storage + 655;
+return dev_storage + 656;
 
 }
                     }
@@ -11165,7 +11181,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS63", 11) == 0)
                     {
 {
-return dev_storage + 654;
+return dev_storage + 655;
 
 }
                     }
@@ -11180,7 +11196,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS62", 11) == 0)
                     {
 {
-return dev_storage + 653;
+return dev_storage + 654;
 
 }
                     }
@@ -11195,7 +11211,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS61", 11) == 0)
                     {
 {
-return dev_storage + 652;
+return dev_storage + 653;
 
 }
                     }
@@ -11210,7 +11226,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS60", 11) == 0)
                     {
 {
-return dev_storage + 651;
+return dev_storage + 652;
 
 }
                     }
@@ -11402,7 +11418,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS59", 11) == 0)
                     {
 {
-return dev_storage + 650;
+return dev_storage + 651;
 
 }
                     }
@@ -11417,7 +11433,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS58", 11) == 0)
                     {
 {
-return dev_storage + 649;
+return dev_storage + 650;
 
 }
                     }
@@ -11432,7 +11448,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS57", 11) == 0)
                     {
 {
-return dev_storage + 648;
+return dev_storage + 649;
 
 }
                     }
@@ -11447,7 +11463,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS56", 11) == 0)
                     {
 {
-return dev_storage + 647;
+return dev_storage + 648;
 
 }
                     }
@@ -11462,7 +11478,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS55", 11) == 0)
                     {
 {
-return dev_storage + 646;
+return dev_storage + 647;
 
 }
                     }
@@ -11477,7 +11493,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS54", 11) == 0)
                     {
 {
-return dev_storage + 645;
+return dev_storage + 646;
 
 }
                     }
@@ -11492,7 +11508,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS53", 11) == 0)
                     {
 {
-return dev_storage + 644;
+return dev_storage + 645;
 
 }
                     }
@@ -11507,7 +11523,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS52", 11) == 0)
                     {
 {
-return dev_storage + 643;
+return dev_storage + 644;
 
 }
                     }
@@ -11522,7 +11538,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS51", 11) == 0)
                     {
 {
-return dev_storage + 642;
+return dev_storage + 643;
 
 }
                     }
@@ -11537,7 +11553,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS50", 11) == 0)
                     {
 {
-return dev_storage + 641;
+return dev_storage + 642;
 
 }
                     }
@@ -11729,7 +11745,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS49", 11) == 0)
                     {
 {
-return dev_storage + 640;
+return dev_storage + 641;
 
 }
                     }
@@ -11744,7 +11760,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS48", 11) == 0)
                     {
 {
-return dev_storage + 639;
+return dev_storage + 640;
 
 }
                     }
@@ -11759,7 +11775,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS47", 11) == 0)
                     {
 {
-return dev_storage + 638;
+return dev_storage + 639;
 
 }
                     }
@@ -11774,7 +11790,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS46", 11) == 0)
                     {
 {
-return dev_storage + 637;
+return dev_storage + 638;
 
 }
                     }
@@ -11789,7 +11805,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS45", 11) == 0)
                     {
 {
-return dev_storage + 636;
+return dev_storage + 637;
 
 }
                     }
@@ -11804,7 +11820,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS44", 11) == 0)
                     {
 {
-return dev_storage + 635;
+return dev_storage + 636;
 
 }
                     }
@@ -11819,7 +11835,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS43", 11) == 0)
                     {
 {
-return dev_storage + 634;
+return dev_storage + 635;
 
 }
                     }
@@ -11834,7 +11850,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS42", 11) == 0)
                     {
 {
-return dev_storage + 633;
+return dev_storage + 634;
 
 }
                     }
@@ -11849,7 +11865,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS41", 11) == 0)
                     {
 {
-return dev_storage + 632;
+return dev_storage + 633;
 
 }
                     }
@@ -11864,7 +11880,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS40", 11) == 0)
                     {
 {
-return dev_storage + 631;
+return dev_storage + 632;
 
 }
                     }
@@ -12056,7 +12072,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS39", 11) == 0)
                     {
 {
-return dev_storage + 630;
+return dev_storage + 631;
 
 }
                     }
@@ -12071,7 +12087,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS38", 11) == 0)
                     {
 {
-return dev_storage + 629;
+return dev_storage + 630;
 
 }
                     }
@@ -12086,7 +12102,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS37", 11) == 0)
                     {
 {
-return dev_storage + 628;
+return dev_storage + 629;
 
 }
                     }
@@ -12101,7 +12117,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS36", 11) == 0)
                     {
 {
-return dev_storage + 627;
+return dev_storage + 628;
 
 }
                     }
@@ -12116,7 +12132,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS35", 11) == 0)
                     {
 {
-return dev_storage + 626;
+return dev_storage + 627;
 
 }
                     }
@@ -12131,7 +12147,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS34", 11) == 0)
                     {
 {
-return dev_storage + 625;
+return dev_storage + 626;
 
 }
                     }
@@ -12146,7 +12162,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS33", 11) == 0)
                     {
 {
-return dev_storage + 624;
+return dev_storage + 625;
 
 }
                     }
@@ -12161,7 +12177,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS32", 11) == 0)
                     {
 {
-return dev_storage + 623;
+return dev_storage + 624;
 
 }
                     }
@@ -12176,7 +12192,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS31", 11) == 0)
                     {
 {
-return dev_storage + 622;
+return dev_storage + 623;
 
 }
                     }
@@ -12191,7 +12207,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS30", 11) == 0)
                     {
 {
-return dev_storage + 621;
+return dev_storage + 622;
 
 }
                     }
@@ -12383,7 +12399,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS29", 11) == 0)
                     {
 {
-return dev_storage + 620;
+return dev_storage + 621;
 
 }
                     }
@@ -12398,7 +12414,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS28", 11) == 0)
                     {
 {
-return dev_storage + 619;
+return dev_storage + 620;
 
 }
                     }
@@ -12413,7 +12429,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS27", 11) == 0)
                     {
 {
-return dev_storage + 618;
+return dev_storage + 619;
 
 }
                     }
@@ -12428,7 +12444,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS26", 11) == 0)
                     {
 {
-return dev_storage + 617;
+return dev_storage + 618;
 
 }
                     }
@@ -12443,7 +12459,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS25", 11) == 0)
                     {
 {
-return dev_storage + 616;
+return dev_storage + 617;
 
 }
                     }
@@ -12458,7 +12474,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS24", 11) == 0)
                     {
 {
-return dev_storage + 615;
+return dev_storage + 616;
 
 }
                     }
@@ -12473,7 +12489,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS23", 11) == 0)
                     {
 {
-return dev_storage + 614;
+return dev_storage + 615;
 
 }
                     }
@@ -12488,7 +12504,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS22", 11) == 0)
                     {
 {
-return dev_storage + 613;
+return dev_storage + 614;
 
 }
                     }
@@ -12503,7 +12519,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS21", 11) == 0)
                     {
 {
-return dev_storage + 612;
+return dev_storage + 613;
 
 }
                     }
@@ -12518,7 +12534,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS20", 11) == 0)
                     {
 {
-return dev_storage + 611;
+return dev_storage + 612;
 
 }
                     }
@@ -12542,7 +12558,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty127", 11) == 0)
                     {
 {
-return dev_storage + 425;
+return dev_storage + 426;
 
 }
                     }
@@ -12557,7 +12573,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty126", 11) == 0)
                     {
 {
-return dev_storage + 424;
+return dev_storage + 425;
 
 }
                     }
@@ -12572,7 +12588,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty125", 11) == 0)
                     {
 {
-return dev_storage + 423;
+return dev_storage + 424;
 
 }
                     }
@@ -12587,7 +12603,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty124", 11) == 0)
                     {
 {
-return dev_storage + 422;
+return dev_storage + 423;
 
 }
                     }
@@ -12602,7 +12618,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty123", 11) == 0)
                     {
 {
-return dev_storage + 421;
+return dev_storage + 422;
 
 }
                     }
@@ -12617,7 +12633,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty122", 11) == 0)
                     {
 {
-return dev_storage + 420;
+return dev_storage + 421;
 
 }
                     }
@@ -12632,7 +12648,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty121", 11) == 0)
                     {
 {
-return dev_storage + 419;
+return dev_storage + 420;
 
 }
                     }
@@ -12647,7 +12663,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty120", 11) == 0)
                     {
 {
-return dev_storage + 418;
+return dev_storage + 419;
 
 }
                     }
@@ -12671,7 +12687,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst127", 11) == 0)
                     {
 {
-return dev_storage + 295;
+return dev_storage + 296;
 
 }
                     }
@@ -12686,7 +12702,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst126", 11) == 0)
                     {
 {
-return dev_storage + 294;
+return dev_storage + 295;
 
 }
                     }
@@ -12701,7 +12717,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst125", 11) == 0)
                     {
 {
-return dev_storage + 293;
+return dev_storage + 294;
 
 }
                     }
@@ -12716,7 +12732,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst124", 11) == 0)
                     {
 {
-return dev_storage + 292;
+return dev_storage + 293;
 
 }
                     }
@@ -12731,7 +12747,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst123", 11) == 0)
                     {
 {
-return dev_storage + 291;
+return dev_storage + 292;
 
 }
                     }
@@ -12746,7 +12762,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst122", 11) == 0)
                     {
 {
-return dev_storage + 290;
+return dev_storage + 291;
 
 }
                     }
@@ -12761,7 +12777,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst121", 11) == 0)
                     {
 {
-return dev_storage + 289;
+return dev_storage + 290;
 
 }
                     }
@@ -12776,7 +12792,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst120", 11) == 0)
                     {
 {
-return dev_storage + 288;
+return dev_storage + 289;
 
 }
                     }
@@ -12968,7 +12984,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS19", 11) == 0)
                     {
 {
-return dev_storage + 610;
+return dev_storage + 611;
 
 }
                     }
@@ -12983,7 +12999,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS18", 11) == 0)
                     {
 {
-return dev_storage + 609;
+return dev_storage + 610;
 
 }
                     }
@@ -12998,7 +13014,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS17", 11) == 0)
                     {
 {
-return dev_storage + 608;
+return dev_storage + 609;
 
 }
                     }
@@ -13013,7 +13029,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS16", 11) == 0)
                     {
 {
-return dev_storage + 607;
+return dev_storage + 608;
 
 }
                     }
@@ -13028,7 +13044,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS15", 11) == 0)
                     {
 {
-return dev_storage + 606;
+return dev_storage + 607;
 
 }
                     }
@@ -13043,7 +13059,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS14", 11) == 0)
                     {
 {
-return dev_storage + 605;
+return dev_storage + 606;
 
 }
                     }
@@ -13058,7 +13074,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS13", 11) == 0)
                     {
 {
-return dev_storage + 604;
+return dev_storage + 605;
 
 }
                     }
@@ -13073,7 +13089,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS12", 11) == 0)
                     {
 {
-return dev_storage + 603;
+return dev_storage + 604;
 
 }
                     }
@@ -13088,7 +13104,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS11", 11) == 0)
                     {
 {
-return dev_storage + 602;
+return dev_storage + 603;
 
 }
                     }
@@ -13103,7 +13119,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS10", 11) == 0)
                     {
 {
-return dev_storage + 601;
+return dev_storage + 602;
 
 }
                     }
@@ -13127,7 +13143,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty119", 11) == 0)
                     {
 {
-return dev_storage + 417;
+return dev_storage + 418;
 
 }
                     }
@@ -13142,7 +13158,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty118", 11) == 0)
                     {
 {
-return dev_storage + 416;
+return dev_storage + 417;
 
 }
                     }
@@ -13157,7 +13173,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty117", 11) == 0)
                     {
 {
-return dev_storage + 415;
+return dev_storage + 416;
 
 }
                     }
@@ -13172,7 +13188,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty116", 11) == 0)
                     {
 {
-return dev_storage + 414;
+return dev_storage + 415;
 
 }
                     }
@@ -13187,7 +13203,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty115", 11) == 0)
                     {
 {
-return dev_storage + 413;
+return dev_storage + 414;
 
 }
                     }
@@ -13202,7 +13218,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty114", 11) == 0)
                     {
 {
-return dev_storage + 412;
+return dev_storage + 413;
 
 }
                     }
@@ -13217,7 +13233,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty113", 11) == 0)
                     {
 {
-return dev_storage + 411;
+return dev_storage + 412;
 
 }
                     }
@@ -13232,7 +13248,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty112", 11) == 0)
                     {
 {
-return dev_storage + 410;
+return dev_storage + 411;
 
 }
                     }
@@ -13247,7 +13263,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty111", 11) == 0)
                     {
 {
-return dev_storage + 409;
+return dev_storage + 410;
 
 }
                     }
@@ -13262,7 +13278,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty110", 11) == 0)
                     {
 {
-return dev_storage + 408;
+return dev_storage + 409;
 
 }
                     }
@@ -13286,7 +13302,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst119", 11) == 0)
                     {
 {
-return dev_storage + 287;
+return dev_storage + 288;
 
 }
                     }
@@ -13301,7 +13317,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst118", 11) == 0)
                     {
 {
-return dev_storage + 286;
+return dev_storage + 287;
 
 }
                     }
@@ -13316,7 +13332,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst117", 11) == 0)
                     {
 {
-return dev_storage + 285;
+return dev_storage + 286;
 
 }
                     }
@@ -13331,7 +13347,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst116", 11) == 0)
                     {
 {
-return dev_storage + 284;
+return dev_storage + 285;
 
 }
                     }
@@ -13346,7 +13362,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst115", 11) == 0)
                     {
 {
-return dev_storage + 283;
+return dev_storage + 284;
 
 }
                     }
@@ -13361,7 +13377,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst114", 11) == 0)
                     {
 {
-return dev_storage + 282;
+return dev_storage + 283;
 
 }
                     }
@@ -13376,7 +13392,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst113", 11) == 0)
                     {
 {
-return dev_storage + 281;
+return dev_storage + 282;
 
 }
                     }
@@ -13391,7 +13407,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst112", 11) == 0)
                     {
 {
-return dev_storage + 280;
+return dev_storage + 281;
 
 }
                     }
@@ -13406,7 +13422,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst111", 11) == 0)
                     {
 {
-return dev_storage + 279;
+return dev_storage + 280;
 
 }
                     }
@@ -13421,7 +13437,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst110", 11) == 0)
                     {
 {
-return dev_storage + 278;
+return dev_storage + 279;
 
 }
                     }
@@ -13613,7 +13629,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty109", 11) == 0)
                     {
 {
-return dev_storage + 407;
+return dev_storage + 408;
 
 }
                     }
@@ -13628,7 +13644,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty108", 11) == 0)
                     {
 {
-return dev_storage + 406;
+return dev_storage + 407;
 
 }
                     }
@@ -13643,7 +13659,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty107", 11) == 0)
                     {
 {
-return dev_storage + 405;
+return dev_storage + 406;
 
 }
                     }
@@ -13658,7 +13674,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty106", 11) == 0)
                     {
 {
-return dev_storage + 404;
+return dev_storage + 405;
 
 }
                     }
@@ -13673,7 +13689,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty105", 11) == 0)
                     {
 {
-return dev_storage + 403;
+return dev_storage + 404;
 
 }
                     }
@@ -13688,7 +13704,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty104", 11) == 0)
                     {
 {
-return dev_storage + 402;
+return dev_storage + 403;
 
 }
                     }
@@ -13703,7 +13719,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty103", 11) == 0)
                     {
 {
-return dev_storage + 401;
+return dev_storage + 402;
 
 }
                     }
@@ -13718,7 +13734,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty102", 11) == 0)
                     {
 {
-return dev_storage + 400;
+return dev_storage + 401;
 
 }
                     }
@@ -13733,7 +13749,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty101", 11) == 0)
                     {
 {
-return dev_storage + 399;
+return dev_storage + 400;
 
 }
                     }
@@ -13748,7 +13764,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/pty100", 11) == 0)
                     {
 {
-return dev_storage + 398;
+return dev_storage + 399;
 
 }
                     }
@@ -13772,7 +13788,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst109", 11) == 0)
                     {
 {
-return dev_storage + 277;
+return dev_storage + 278;
 
 }
                     }
@@ -13787,7 +13803,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst108", 11) == 0)
                     {
 {
-return dev_storage + 276;
+return dev_storage + 277;
 
 }
                     }
@@ -13802,7 +13818,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst107", 11) == 0)
                     {
 {
-return dev_storage + 275;
+return dev_storage + 276;
 
 }
                     }
@@ -13817,7 +13833,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst106", 11) == 0)
                     {
 {
-return dev_storage + 274;
+return dev_storage + 275;
 
 }
                     }
@@ -13832,7 +13848,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst105", 11) == 0)
                     {
 {
-return dev_storage + 273;
+return dev_storage + 274;
 
 }
                     }
@@ -13847,7 +13863,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst104", 11) == 0)
                     {
 {
-return dev_storage + 272;
+return dev_storage + 273;
 
 }
                     }
@@ -13862,7 +13878,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst103", 11) == 0)
                     {
 {
-return dev_storage + 271;
+return dev_storage + 272;
 
 }
                     }
@@ -13877,7 +13893,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst102", 11) == 0)
                     {
 {
-return dev_storage + 270;
+return dev_storage + 271;
 
 }
                     }
@@ -13892,7 +13908,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst101", 11) == 0)
                     {
 {
-return dev_storage + 269;
+return dev_storage + 270;
 
 }
                     }
@@ -13907,7 +13923,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/nst100", 11) == 0)
                     {
 {
-return dev_storage + 268;
+return dev_storage + 269;
 
 }
                     }
@@ -13943,7 +13959,7 @@ return	NULL;
           if (strncmp (KR_keyword, "/dev/windows", 12) == 0)
             {
 {
-return dev_storage + 720;
+return dev_storage + 721;
 
 }
             }
@@ -13958,7 +13974,7 @@ return	NULL;
           if (strncmp (KR_keyword, "/dev/urandom", 12) == 0)
             {
 {
-return dev_storage + 719;
+return dev_storage + 720;
 
 }
             }
@@ -13994,7 +14010,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS127", 12) == 0)
                     {
 {
-return dev_storage + 718;
+return dev_storage + 719;
 
 }
                     }
@@ -14009,7 +14025,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS126", 12) == 0)
                     {
 {
-return dev_storage + 717;
+return dev_storage + 718;
 
 }
                     }
@@ -14024,7 +14040,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS125", 12) == 0)
                     {
 {
-return dev_storage + 716;
+return dev_storage + 717;
 
 }
                     }
@@ -14039,7 +14055,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS124", 12) == 0)
                     {
 {
-return dev_storage + 715;
+return dev_storage + 716;
 
 }
                     }
@@ -14054,7 +14070,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS123", 12) == 0)
                     {
 {
-return dev_storage + 714;
+return dev_storage + 715;
 
 }
                     }
@@ -14069,7 +14085,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS122", 12) == 0)
                     {
 {
-return dev_storage + 713;
+return dev_storage + 714;
 
 }
                     }
@@ -14084,7 +14100,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS121", 12) == 0)
                     {
 {
-return dev_storage + 712;
+return dev_storage + 713;
 
 }
                     }
@@ -14099,7 +14115,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS120", 12) == 0)
                     {
 {
-return dev_storage + 711;
+return dev_storage + 712;
 
 }
                     }
@@ -14261,7 +14277,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS119", 12) == 0)
                     {
 {
-return dev_storage + 710;
+return dev_storage + 711;
 
 }
                     }
@@ -14276,7 +14292,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS118", 12) == 0)
                     {
 {
-return dev_storage + 709;
+return dev_storage + 710;
 
 }
                     }
@@ -14291,7 +14307,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS117", 12) == 0)
                     {
 {
-return dev_storage + 708;
+return dev_storage + 709;
 
 }
                     }
@@ -14306,7 +14322,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS116", 12) == 0)
                     {
 {
-return dev_storage + 707;
+return dev_storage + 708;
 
 }
                     }
@@ -14321,7 +14337,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS115", 12) == 0)
                     {
 {
-return dev_storage + 706;
+return dev_storage + 707;
 
 }
                     }
@@ -14336,7 +14352,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS114", 12) == 0)
                     {
 {
-return dev_storage + 705;
+return dev_storage + 706;
 
 }
                     }
@@ -14351,7 +14367,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS113", 12) == 0)
                     {
 {
-return dev_storage + 704;
+return dev_storage + 705;
 
 }
                     }
@@ -14366,7 +14382,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS112", 12) == 0)
                     {
 {
-return dev_storage + 703;
+return dev_storage + 704;
 
 }
                     }
@@ -14381,7 +14397,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS111", 12) == 0)
                     {
 {
-return dev_storage + 702;
+return dev_storage + 703;
 
 }
                     }
@@ -14396,7 +14412,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS110", 12) == 0)
                     {
 {
-return dev_storage + 701;
+return dev_storage + 702;
 
 }
                     }
@@ -14588,7 +14604,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS109", 12) == 0)
                     {
 {
-return dev_storage + 700;
+return dev_storage + 701;
 
 }
                     }
@@ -14603,7 +14619,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS108", 12) == 0)
                     {
 {
-return dev_storage + 699;
+return dev_storage + 700;
 
 }
                     }
@@ -14618,7 +14634,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS107", 12) == 0)
                     {
 {
-return dev_storage + 698;
+return dev_storage + 699;
 
 }
                     }
@@ -14633,7 +14649,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS106", 12) == 0)
                     {
 {
-return dev_storage + 697;
+return dev_storage + 698;
 
 }
                     }
@@ -14648,7 +14664,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS105", 12) == 0)
                     {
 {
-return dev_storage + 696;
+return dev_storage + 697;
 
 }
                     }
@@ -14663,7 +14679,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS104", 12) == 0)
                     {
 {
-return dev_storage + 695;
+return dev_storage + 696;
 
 }
                     }
@@ -14678,7 +14694,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS103", 12) == 0)
                     {
 {
-return dev_storage + 694;
+return dev_storage + 695;
 
 }
                     }
@@ -14693,7 +14709,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS102", 12) == 0)
                     {
 {
-return dev_storage + 693;
+return dev_storage + 694;
 
 }
                     }
@@ -14708,7 +14724,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS101", 12) == 0)
                     {
 {
-return dev_storage + 692;
+return dev_storage + 693;
 
 }
                     }
@@ -14723,7 +14739,7 @@ return	NULL;
                   if (strncmp (KR_keyword, "/dev/ttyS100", 12) == 0)
                     {
 {
-return dev_storage + 691;
+return dev_storage + 692;
 
 }
                     }
diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index 46568acbb..2545dd85e 100644
--- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -180,6 +180,7 @@ const _device dev_error_storage =
 "/dev/console", BRACK(FH_CONSOLE), "/dev/console", exists_console, S_IFCHR, =console_dev
 "/dev/ptmx", BRACK(FH_PTMX), "/dev/ptmx", exists, S_IFCHR
 "/dev/windows", BRACK(FH_WINDOWS), "\\Device\\Null", exists_ntdev, S_IFCHR
+"/dev/mixer", BRACK(FH_OSS_MIXER), "\\Device\\Null", exists_ntdev, S_IFCHR
 "/dev/dsp", BRACK(FH_OSS_DSP), "\\Device\\Null", exists_ntdev, S_IFCHR
 "/dev/conin", BRACK(FH_CONIN), "/dev/conin", exists_console, S_IFCHR
 "/dev/conout", BRACK(FH_CONOUT), "/dev/conout", exists_console, S_IFCHR
diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index 156445119..21d525389 100644
--- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -552,6 +552,9 @@ fh_alloc (path_conv& pc)
 	case FH_CLIPBOARD:
 	  fh = cnew (fhandler_dev_clipboard);
 	  break;
+	case FH_OSS_MIXER:
+	  fh = cnew (fhandler_dev_mixer);
+	  break;
 	case FH_OSS_DSP:
 	  fh = cnew (fhandler_dev_dsp);
 	  break;
diff --git a/winsup/cygwin/fhandler/mixer.cc b/winsup/cygwin/fhandler/mixer.cc
new file mode 100644
index 000000000..fabd397b7
--- /dev/null
+++ b/winsup/cygwin/fhandler/mixer.cc
@@ -0,0 +1,152 @@
+/* fhandler_dev_mixer: code to emulate OSS sound model /dev/mixer
+
+   Written by Takashi Yano <takashi.yano@nifty.ne.jp>
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include "winsup.h"
+#include <sys/soundcard.h>
+#include "cygerrno.h"
+#include "path.h"
+#include "fhandler.h"
+#include "dtable.h"
+#include "cygheap.h"
+
+ssize_t
+fhandler_dev_mixer::write (const void *ptr, size_t len)
+{
+  set_errno (EINVAL);
+  return -1;
+}
+
+void
+fhandler_dev_mixer::read (void *ptr, size_t& len)
+{
+  len = -1;
+  set_errno (EINVAL);
+}
+
+int
+fhandler_dev_mixer::open (int flags, mode_t)
+{
+  int ret = -1, err = 0;
+  switch (flags & O_ACCMODE)
+    {
+    case O_RDWR:
+    case O_WRONLY:
+    case O_RDONLY:
+      if (waveInGetNumDevs () == 0 && waveOutGetNumDevs () == 0)
+	err = ENXIO;
+      break;
+    default:
+      err = EINVAL;
+    }
+
+  if (err)
+    set_errno (err);
+  else
+    {
+      ret = open_null (flags);
+      rec_source = SOUND_MIXER_MIC;
+    }
+
+  return ret;
+}
+
+static DWORD
+volume_oss_to_winmm (int vol_oss)
+{
+  unsigned int vol_l, vol_r;
+  DWORD vol_winmm;
+
+  vol_l = ((unsigned int) vol_oss) & 0xff;
+  vol_r = ((unsigned int) vol_oss) >> 8;
+  vol_l = min ((vol_l * 65535 + 50) / 100, 65535);
+  vol_r = min ((vol_r * 65535 + 50) / 100, 65535);
+  vol_winmm = (vol_r << 16) | vol_l;
+
+  return vol_winmm;
+}
+
+static int
+volume_winmm_to_oss (DWORD vol_winmm)
+{
+  int vol_l, vol_r;
+
+  vol_l = vol_winmm & 0xffff;
+  vol_r = vol_winmm >> 16;
+  vol_l = min ((vol_l * 100 + 32768) / 65535, 100);
+  vol_r = min ((vol_r * 100 + 32768) / 65535, 100);
+  return (vol_r << 8) | vol_l;
+}
+
+int
+fhandler_dev_mixer::ioctl (unsigned int cmd, void *buf)
+{
+  int ret = 0;
+  DWORD vol;
+  switch (cmd)
+    {
+    case SOUND_MIXER_READ_DEVMASK:
+      *(int *) buf = SOUND_MASK_VOLUME | SOUND_MASK_MIC | SOUND_MASK_LINE;
+      break;
+    case SOUND_MIXER_READ_RECMASK:
+      *(int *) buf = SOUND_MASK_MIC | SOUND_MASK_LINE;
+      break;
+    case SOUND_MIXER_READ_STEREODEVS:
+      *(int *) buf = SOUND_MASK_VOLUME | SOUND_MASK_LINE;
+      break;
+    case SOUND_MIXER_READ_CAPS:
+      *(int *) buf = SOUND_CAP_EXCL_INPUT;
+      break;
+    case MIXER_WRITE (SOUND_MIXER_RECSRC):
+      /* Dummy implementation */
+      if (*(int *) buf == 0 || ((*(int *) buf) & SOUND_MASK_MIC))
+	rec_source = SOUND_MIXER_MIC;
+      else if ((*(int *) buf) & SOUND_MASK_LINE)
+	rec_source = SOUND_MIXER_LINE;
+      break;
+    case MIXER_READ (SOUND_MIXER_RECSRC):
+      /* Dummy implementation */
+      *(int *) buf = 1 << rec_source;
+      break;
+    case MIXER_WRITE (SOUND_MIXER_VOLUME):
+      vol = volume_oss_to_winmm (*(int *) buf);
+      if (waveOutSetVolume ((HWAVEOUT)WAVE_MAPPER, vol) != MMSYSERR_NOERROR)
+	{
+	  set_errno (EINVAL);
+	  ret = -1;
+	}
+      break;
+    case MIXER_READ (SOUND_MIXER_VOLUME):
+      DWORD vol;
+      if (waveOutGetVolume ((HWAVEOUT)WAVE_MAPPER, &vol) != MMSYSERR_NOERROR)
+	{
+	  set_errno (EINVAL);
+	  ret = -1;
+	  break;
+	}
+      *(int *) buf = volume_winmm_to_oss (vol);
+      break;
+    default:
+      for (int i = 0; i < SOUND_MIXER_NRDEVICES; i++)
+	{
+	  if (cmd == (unsigned int) MIXER_WRITE (i))
+	    goto out;
+	  if (cmd == (unsigned int) MIXER_READ (i))
+	    {
+	      *(int *) buf = 0;
+	      goto out;
+	    }
+	}
+      set_errno (EINVAL);
+      ret = -1;
+      break;
+    }
+out:
+  return ret;
+}
diff --git a/winsup/cygwin/local_includes/devices.h b/winsup/cygwin/local_includes/devices.h
index 8f718dd17..10035263d 100644
--- a/winsup/cygwin/local_includes/devices.h
+++ b/winsup/cygwin/local_includes/devices.h
@@ -242,6 +242,7 @@ enum fh_devices
   FH_URANDOM = FHDEV (DEV_MEM_MAJOR, 9),
 
   DEV_SOUND_MAJOR = 14,
+  FH_OSS_MIXER = FHDEV (DEV_SOUND_MAJOR, 0),
   FH_OSS_DSP = FHDEV (DEV_SOUND_MAJOR, 3),
 
   DEV_SOCK_MAJOR = 30,
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 098b8dd19..f2658a242 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2777,6 +2777,35 @@ class fhandler_windows: public fhandler_base
   }
 };
 
+class fhandler_dev_mixer: public fhandler_base
+{
+ private:
+  int rec_source;
+ public:
+  fhandler_dev_mixer () {}
+  int open (int, mode_t mode = 0);
+  ssize_t write (const void *, size_t);
+  void read (void *, size_t&);
+  int ioctl (unsigned int, void *);
+
+  fhandler_dev_mixer (void *) {}
+
+  void copy_from (fhandler_base *x)
+  {
+    pc.free_strings ();
+    *this = *reinterpret_cast<fhandler_dev_mixer *> (x);
+    _copy_from_reset_helper ();
+  }
+
+  fhandler_dev_mixer *clone (cygheap_types malloc_type = HEAP_FHANDLER)
+  {
+    void *ptr = (void *) ccalloc (malloc_type, 1, sizeof (fhandler_dev_mixer));
+    fhandler_dev_mixer *fh = new (ptr) fhandler_dev_mixer (ptr);
+    fh->copy_from (this);
+    return fh;
+  }
+};
+
 class fhandler_dev_dsp: public fhandler_base
 {
  public:
diff --git a/winsup/cygwin/release/3.5.0 b/winsup/cygwin/release/3.5.0
index 91c470442..cdb175797 100644
--- a/winsup/cygwin/release/3.5.0
+++ b/winsup/cygwin/release/3.5.0
@@ -31,6 +31,8 @@ What's new:
 
 - New API calls: c8rtomb, c16rtomb, c32rtomb, mbrtoc8, mbrtoc16, mbrtoc32.
 
+- Implement OSS-based sound mixer device (/dev/mixer).
+
 What changed:
 -------------
 
-- 
2.39.0

