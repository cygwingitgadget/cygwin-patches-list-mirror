From: "Charles S. Wilson" <cwilson@ece.gatech.edu>
To: cygwin-patches@sourceware.cygnus.com
Subject: [PATCH] include regsub() in cygwin1.dll
Date: Wed, 10 May 2000 21:51:00 -0000
Message-id: <391A3D81.15EFF58@ece.gatech.edu>
X-SW-Source: 2000-q2/msg00051.html

The attached (untested but trivial) patch should insure that regsub() is
included in cygwin1.dll. See 
http://sourceware.cygnus.com/ml/cygwin/2000-05/msg00354.html


ChangeLog:
==========

Thu May 11 00:54:00 2000  Charles Wilson <cwilson@ece.gatech.edu>

        * cygwin.din: insure that regsub() is included in
        cygwin1.dll

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.6
diff -u -r1.6 cygwin.din
--- cygwin.din  2000/04/24 15:44:11     1.6
+++ cygwin.din  2000/05/11 03:52:00
@@ -566,6 +566,8 @@
 _regerror = regerror
 regfree
 _regfree = regfree
+regsub
+_regsub = regsub
 remainder
 _remainder = remainder
 remainderf


begin 664 cygwin.din.patch.gz
M'XL("'<O&CD``V-Y9W=I;BYD:6XN<&%T8V@`I9#=BL,@$(6O.T\Q]]:J:1(6
MH1#H56]W'Z"TB0:A:Y9QDW;??C7V#WI90<XW<V8XXLYWYJ*Q_>O/SJ\ZYV'S
M_H'/[1=:=S(:13L%$:B=;XP(XX_(8>*1N9R`S"\Y,SG?(T4);O"H5C5TSEKD
M(W**U?,S.>=/Y:*04@I9BJ)$5>FRU$HMTCYC['6L$DJA7.NJT%)"TR"OZGI9
M(TOR@4T#N"?3&Z*!<(,WA$26C,EVHNS./18AC$=@^PS92IVHWP<7/YKFQ2O/
._KU_1PO_\`$)-Y,!```W
`
end
