Return-Path: <cygwin-patches-return-3141-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31647 invoked by alias); 9 Nov 2002 00:19:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31633 invoked from network); 9 Nov 2002 00:19:15 -0000
Message-ID: <015501c28785$48c64a30$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: FIONREAD for pipes implementation.
Date: Fri, 08 Nov 2002 16:19:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00092.txt.bz2

The patch implements ioctl(fd, FIONREAD, ...) call when fd is a pipe.

2002-11-06  Sergey Okhapkin  <sos@prospect.com.ru>

        * fhandler.h (class fhandler_pipe): New ioctl() method.
        * pipe.cc (fhandler_pipe::ioctl): New.


Index: fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.145
diff -u -p -r1.145 fhandler.h
--- fhandler.h 5 Nov 2002 23:15:04 -0000 1.145
+++ fhandler.h 9 Nov 2002 00:09:27 -0000
@@ -459,6 +459,7 @@ class fhandler_pipe: public fhandler_bas
   int close ();
   void create_guard (SECURITY_ATTRIBUTES *sa) {guard = CreateMutex (sa,
FALSE, NULL);}
   int dup (fhandler_base *child);
+  int ioctl (unsigned int cmd, void *);
   void fixup_after_fork (HANDLE);
   bool hit_eof ();
   void set_eof () {broken_pipe = true;}
Index: pipe.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pipe.cc,v
retrieving revision 1.39
diff -u -p -r1.39 pipe.cc
--- pipe.cc 30 Jul 2002 01:31:51 -0000 1.39
+++ pipe.cc 9 Nov 2002 00:09:28 -0000
@@ -13,6 +13,7 @@ details. */
 #include "winsup.h"
 #include <unistd.h>
 #include <errno.h>
+#include <sys/socket.h>
 #include "cygerrno.h"
 #include "security.h"
 #include "fhandler.h"
@@ -177,6 +178,33 @@ make_pipe (int fildes[2], unsigned int p
   syscall_printf ("%d = make_pipe ([%d, %d], %d, %p)", res, fildes[0],
     fildes[1], psize, mode);
   return res;
+}
+
+int
+fhandler_pipe::ioctl (unsigned int cmd, void *p)
+{
+  int n;
+
+  switch (cmd)
+    {
+    case FIONREAD:
+      if (get_device () == FH_PIPEW)
+ {
+   set_errno (EINVAL);
+   return -1;
+ }
+      if (!PeekNamedPipe (get_handle (), NULL, 0, NULL, (DWORD *) &n,
NULL))
+ {
+   __seterrno ();
+   return -1;
+ }
+      break;
+    default:
+      return fhandler_base::ioctl (cmd, p);
+      break;
+    }
+  * (int *) p = n;
+  return 0;
 }

 extern "C" int

Sergey Okhapkin
Somerset, NJ


begin 666 FIONREAD.diff
M26YD97@Z(&9H86YD;&5R+F@*/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/0I20U,@
M9FEL93H@+V-V<R]S<F,O<W)C+W=I;G-U<"]C>6=W:6XO9FAA;F1L97(N:"QV
M"G)E=')I979I;F<@<F5V:7-I;VX@,2XQ-#4*9&EF9B M=2 M<" M<C$N,30U
M(&9H86YD;&5R+F@*+2TM(&9H86YD;&5R+F@)-2!.;W8@,C P,B R,SHQ-3HP
M-" M,# P, DQ+C$T-0HK*RL@9FAA;F1L97(N: DY($YO=B R,# R(# P.C Y
M.C(W("TP,# P"D! ("TT-3DL-B K-#4Y+#<@0$ @8VQA<W,@9FAA;F1L97)?
M<&EP93H@<'5B;&EC(&9H86YD;&5R7V)A<PH@("!I;G0@8VQO<V4@*"D["B @
M('9O:60@8W)E871E7V=U87)D("A314-54DE465]!5%1224)55$53("IS82D@
M>V=U87)D(#T@0W)E871E375T97@@*'-A+"!&04Q312P@3E5,3"D[?0H@("!I
M;G0@9'5P("AF:&%N9&QE<E]B87-E("IC:&EL9"D["BL@(&EN="!I;V-T;" H
M=6YS:6=N960@:6YT(&-M9"P@=F]I9" J*3L*(" @=F]I9"!F:7AU<%]A9G1E
M<E]F;W)K("A(04Y$3$4I.PH@("!B;V]L(&AI=%]E;V8@*"D["B @('9O:60@
M<V5T7V5O9B H*2![8G)O:V5N7W!I<&4@/2!T<G5E.WT*26YD97@Z('!I<&4N
M8V,*/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/0I20U,@9FEL93H@+V-V<R]S<F,O
M<W)C+W=I;G-U<"]C>6=W:6XO<&EP92YC8RQV"G)E=')I979I;F<@<F5V:7-I
M;VX@,2XS.0ID:69F("UU("UP("UR,2XS.2!P:7!E+F-C"BTM+2!P:7!E+F-C
M"3,P($IU;" R,# R(# Q.C,Q.C4Q("TP,# P"3$N,SD**RLK('!I<&4N8V,)
M.2!.;W8@,C P,B P,#HP.3HR." M,# P, I 0" M,3,L-B K,3,L-R! 0"!D
M971A:6QS+B J+PH@(VEN8VQU9&4@(G=I;G-U<"YH(@H@(VEN8VQU9&4@/'5N
M:7-T9"YH/@H@(VEN8VQU9&4@/&5R<FYO+F@^"BLC:6YC;'5D92 \<WES+W-O
M8VME="YH/@H@(VEN8VQU9&4@(F-Y9V5R<FYO+F@B"B C:6YC;'5D92 B<V5C
M=7)I='DN:"(*("-I;F-L=61E(")F:&%N9&QE<BYH(@I 0" M,3<W+#8@*S$W
M."PS,R! 0"!M86ME7W!I<&4@*&EN="!F:6QD97-;,ETL('5N<VEG;F5D(&EN
M="!P"B @('-Y<V-A;&Q?<')I;G1F("@B)60@/2!M86ME7W!I<&4@*%LE9"P@
M)61=+" E9"P@)7 I(BP@<F5S+"!F:6QD97-;,%TL"B )"2 @9FEL9&5S6S%=
M+"!P<VEZ92P@;6]D92D["B @(')E='5R;B!R97,["BM]"BL**VEN= HK9FAA
M;F1L97)?<&EP93HZ:6]C=&P@*'5N<VEG;F5D(&EN="!C;60L('9O:60@*G I
M"BM["BL@(&EN="!N.PHK"BL@('-W:71C:" H8VUD*0HK(" @('L**R @("!C
M87-E($9)3TY214%$.B @"BL@(" @("!I9B H9V5T7V1E=FEC92 H*2 ]/2!&
M2%]025!%5RD**PE["BL)("!S971?97)R;F\@*$5)3E9!3"D["BL)("!R971U
M<FX@+3$["BL)?0HK(" @(" @:68@*"%0965K3F%M9610:7!E("AG971?:&%N
M9&QE("@I+"!.54Q,+" P+"!.54Q,+" H1%=/4D0@*BD@)FXL($Y53$PI*0HK
M"7L**PD@(%]?<V5T97)R;F\@*"D["BL)("!R971U<FX@+3$["BL)?0HK(" @
M(" @8G)E86L["BL@(" @9&5F875L=#H**R @(" @(')E='5R;B!F:&%N9&QE
M<E]B87-E.CII;V-T;" H8VUD+"!P*3L**R @(" @(&)R96%K.PHK(" @('T*
M*R @*B H:6YT("HI(' @/2!N.PHK("!R971U<FX@,#L*('T*( H@97AT97)N
)(")#(B!I;G0*
`
end
