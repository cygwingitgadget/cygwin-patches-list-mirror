Return-Path: <cygwin-patches-return-3132-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30329 invoked by alias); 6 Nov 2002 22:35:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30242 invoked from network); 6 Nov 2002 22:34:53 -0000
Message-ID: <00ba01c285e4$620b2350$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: utmp database manipulations patch
Date: Wed, 06 Nov 2002 14:35:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00083.txt.bz2

The patch fixes some bugs in utmp database support and provides a new
pututline() call.

2002-11-06  Sergey Okhapkin  <sos@prospect.com.ru>

        * cygwin.din (pututline): new exported function.
        * syscalls.cc (login): Use pututiline().
          (setutent): Open utmp as read/write.
          (endutent): Check if utmp file is open.
          (utmpname): call endutent() to close current utmp file.
          (getutid): Enable all cases, use strncmp() to compare ut_id
fields.
          (pututline): New.
        * tty.cc (create_tty_master): Set ut_pid to current pid.


Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.65
diff -u -p -r1.65 cygwin.din
--- cygwin.din 21 Oct 2002 01:00:56 -0000 1.65
+++ cygwin.din 6 Nov 2002 22:07:55 -0000
@@ -621,6 +621,8 @@ putchar_unlocked
 _putchar_unlocked = putchar_unlocked
 puts
 _puts = puts
+pututline
+_pututline = pututline
 putw
 _putw = putw
 qsort
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.231
diff -u -p -r1.231 syscalls.cc
--- syscalls.cc 21 Oct 2002 01:00:57 -0000 1.231
+++ syscalls.cc 6 Nov 2002 22:08:00 -0000
@@ -2427,15 +2427,8 @@ login (struct utmp *ut)
 {
   sigframe thisframe (mainthread);
   register int fd;
-  int currtty = ttyslot ();

-  if (currtty >= 0 && (fd = open (_PATH_UTMP, O_WRONLY | O_CREAT |
O_BINARY,
-      0644)) >= 0)
-    {
-      (void) lseek (fd, (long) (currtty * sizeof (struct utmp)), SEEK_SET);
-      (void) write (fd, (char *) ut, sizeof (struct utmp));
-      (void) close (fd);
-    }
+  pututline (ut);
   if ((fd = open (_PATH_WTMP, O_WRONLY | O_APPEND | O_BINARY, 0)) >= 0)
     {
       (void) write (fd, (char *) ut, sizeof (struct utmp));
@@ -2516,7 +2509,7 @@ setutent ()
   sigframe thisframe (mainthread);
   if (utmp_fd == -2)
     {
-      utmp_fd = open (utmp_file, O_RDONLY);
+      utmp_fd = open (utmp_file, O_RDWR);
     }
   lseek (utmp_fd, 0, SEEK_SET);
 }
@@ -2525,8 +2518,11 @@ extern "C" void
 endutent ()
 {
   sigframe thisframe (mainthread);
-  close (utmp_fd);
-  utmp_fd = -2;
+  if (utmp_fd != -2)
+    {
+      close (utmp_fd);
+      utmp_fd = -2;
+    }
 }

 extern "C" void
@@ -2538,6 +2534,7 @@ utmpname (_CONST char *file)
       debug_printf ("Invalid file");
       return;
     }
+  endutent ();
   utmp_file = strdup (file);
   debug_printf ("New UTMP file: %s", utmp_file);
 }
@@ -2563,7 +2560,6 @@ getutid (struct utmp *id)
     {
       switch (id->ut_type)
  {
-#if 0 /* Not available in Cygwin. */
  case RUN_LVL:
  case BOOT_TIME:
  case OLD_TIME:
@@ -2571,12 +2567,11 @@ getutid (struct utmp *id)
    if (id->ut_type == utmp_data.ut_type)
      return &utmp_data;
    break;
-#endif
  case INIT_PROCESS:
  case LOGIN_PROCESS:
  case USER_PROCESS:
  case DEAD_PROCESS:
-   if (id->ut_id == utmp_data.ut_id)
+   if (strncmp (id->ut_id, utmp_data.ut_id, 2) == 0)
      return &utmp_data;
    break;
  default:
@@ -2601,4 +2596,19 @@ getutline (struct utmp *line)
  return &utmp_data;
     }
   return NULL;
+}
+
+extern "C" void
+pututline (struct utmp *ut)
+{
+  sigframe thisframe (mainthread);
+  if (check_null_invalid_struct (ut))
+    return;
+  setutent ();
+  struct utmp *u;
+  if ((u = getutid (ut)))
+    lseek (utmp_fd, -sizeof(struct utmp), SEEK_CUR);
+  else
+    lseek (utmp_fd, 0, SEEK_END);
+  (void) write (utmp_fd, (char *) ut, sizeof (struct utmp));
 }
Index: tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v
retrieving revision 1.45
diff -u -p -r1.45 tty.cc
--- tty.cc 9 Oct 2002 05:55:40 -0000 1.45
+++ tty.cc 6 Nov 2002 22:08:00 -0000
@@ -88,6 +88,7 @@ create_tty_master (int ttynum)
       cygwin_gethostname (our_utmp.ut_host, sizeof (our_utmp.ut_host));
       __small_sprintf (our_utmp.ut_line, "tty%d", ttynum);
       our_utmp.ut_type = USER_PROCESS;
+      our_utmp.ut_pid = myself->pid;
       myself->ctty = ttynum;
       login (&our_utmp);
     }



Sergey Okhapkin
Somerset, NJ


begin 666 utmp.diff
M/R!U=&UP+F1I9F8*26YD97@Z(&-Y9W=I;BYD:6X*/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/0I20U,@9FEL93H@+V-V<R]S<F,O<W)C+W=I;G-U<"]C>6=W:6XO
M8WEG=VEN+F1I;BQV"G)E=')I979I;F<@<F5V:7-I;VX@,2XV-0ID:69F("UU
M("UP("UR,2XV-2!C>6=W:6XN9&EN"BTM+2!C>6=W:6XN9&EN"3(Q($]C=" R
M,# R(# Q.C P.C4V("TP,# P"3$N-C4**RLK(&-Y9W=I;BYD:6X)-B!.;W8@
M,C P,B R,CHP-SHU-2 M,# P, I 0" M-C(Q+#8@*S8R,2PX($! ('!U=&-H
M87)?=6YL;V-K960*(%]P=71C:&%R7W5N;&]C:V5D(#T@<'5T8VAA<E]U;FQO
M8VME9 H@<'5T<PH@7W!U=',@/2!P=71S"BMP=71U=&QI;F4**U]P=71U=&QI
M;F4@/2!P=71U=&QI;F4*('!U='<*(%]P=71W(#T@<'5T=PH@<7-O<G0*26YD
M97@Z('-Y<V-A;&QS+F-C"CT]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T*4D-3(&9I
M;&4Z("]C=G,O<W)C+W-R8R]W:6YS=7 O8WEG=VEN+W-Y<V-A;&QS+F-C+'8*
M<F5T<FEE=FEN9R!R979I<VEO;B Q+C(S,0ID:69F("UU("UP("UR,2XR,S$@
M<WES8V%L;',N8V,*+2TM('-Y<V-A;&QS+F-C"3(Q($]C=" R,# R(# Q.C P
M.C4W("TP,# P"3$N,C,Q"BLK*R!S>7-C86QL<RYC8PDV($YO=B R,# R(#(R
M.C X.C P("TP,# P"D! ("TR-#(W+#$U("LR-#(W+#@@0$ @;&]G:6X@*'-T
M<G5C="!U=&UP("IU="D*('L*(" @<VEG9G)A;64@=&AI<V9R86UE("AM86EN
M=&AR96%D*3L*(" @<F5G:7-T97(@:6YT(&9D.PHM("!I;G0@8W5R<G1T>2 ]
M('1T>7-L;W0@*"D["B *+2 @:68@*&-U<G)T='D@/CT@," F)B H9F0@/2!O
M<&5N("A?4$%42%]55$U0+"!/7U=23TY,62!\($]?0U)%050@?"!/7T))3D%2
M62P*+0D)"0D)(# V-#0I*2 ^/2 P*0HM(" @('L*+2 @(" @("AV;VED*2!L
M<V5E:R H9F0L("AL;VYG*2 H8W5R<G1T>2 J('-I>F5O9B H<W1R=6-T('5T
M;7 I*2P@4T5%2U]3150I.PHM(" @(" @*'9O:60I('=R:71E("AF9"P@*&-H
M87(@*BD@=70L('-I>F5O9B H<W1R=6-T('5T;7 I*3L*+2 @(" @("AV;VED
M*2!C;&]S92 H9F0I.PHM(" @('T**R @<'5T=71L:6YE("AU="D["B @(&EF
M("@H9F0@/2!O<&5N("A?4$%42%]75$U0+"!/7U=23TY,62!\($]?05!014Y$
M('P@3U]"24Y!4EDL(# I*2 ^/2 P*0H@(" @('L*(" @(" @("AV;VED*2!W
M<FET92 H9F0L("AC:&%R("HI('5T+"!S:7IE;V8@*'-T<G5C="!U=&UP*2D[
M"D! ("TR-3$V+#<@*S(U,#DL-R! 0"!S971U=&5N=" H*0H@("!S:6=F<F%M
M92!T:&ES9G)A;64@*&UA:6YT:')E860I.PH@("!I9B H=71M<%]F9" ]/2 M
M,BD*(" @("!["BT@(" @("!U=&UP7V9D(#T@;W!E;B H=71M<%]F:6QE+"!/
M7U)$3TY,62D["BL@(" @("!U=&UP7V9D(#T@;W!E;B H=71M<%]F:6QE+"!/
M7U)$5U(I.PH@(" @('T*(" @;'-E96L@*'5T;7!?9F0L(# L(%-%14M?4T54
M*3L*('T*0$ @+3(U,C4L." K,C4Q."PQ,2! 0"!E>'1E<FX@(D,B('9O:60*
M(&5N9'5T96YT("@I"B!["B @('-I9V9R86UE('1H:7-F<F%M92 H;6%I;G1H
M<F5A9"D["BT@(&-L;W-E("AU=&UP7V9D*3L*+2 @=71M<%]F9" ]("TR.PHK
M("!I9B H=71M<%]F9" A/2 M,BD**R @("!["BL@(" @("!C;&]S92 H=71M
M<%]F9"D["BL@(" @("!U=&UP7V9D(#T@+3(["BL@(" @?0H@?0H@"B!E>'1E
M<FX@(D,B('9O:60*0$ @+3(U,S@L-B K,C4S-"PW($! ('5T;7!N86UE("A?
M0T].4U0@8VAA<B J9FEL92D*(" @(" @(&1E8G5G7W!R:6YT9B H(DEN=F%L
M:60@9FEL92(I.PH@(" @(" @<F5T=7)N.PH@(" @('T**R @96YD=71E;G0@
M*"D["B @('5T;7!?9FEL92 ]('-T<F1U<" H9FEL92D["B @(&1E8G5G7W!R
M:6YT9B H(DYE=R!55$U0(&9I;&4Z("5S(BP@=71M<%]F:6QE*3L*('T*0$ @
M+3(U-C,L-R K,C4V,"PV($! (&=E='5T:60@*'-T<G5C="!U=&UP("II9"D*
M(" @("!["B @(" @("!S=VET8V@@*&ED+3YU=%]T>7!E*0H@"7L*+2-I9B P
M("\J($YO="!A=F%I;&%B;&4@:6X@0WEG=VEN+B J+PH@"6-A<V4@4E5.7TQ6
M3#H*( EC87-E($)/3U1?5$E-13H*( EC87-E($],1%]424U%.@I 0" M,C4W
M,2PQ,B K,C4V-RPQ,2! 0"!G971U=&ED("AS=')U8W0@=71M<" J:60I"B )
M("!I9B H:60M/G5T7W1Y<&4@/3T@=71M<%]D871A+G5T7W1Y<&4I"B )(" @
M(')E='5R;B F=71M<%]D871A.PH@"2 @8G)E86L["BTC96YD:68*( EC87-E
M($E.251?4%)/0T534SH*( EC87-E($Q/1TE.7U!23T-%4U,Z"B )8V%S92!5
M4T527U!23T-%4U,Z"B )8V%S92!$14%$7U!23T-%4U,Z"BT)("!I9B H:60M
M/G5T7VED(#T]('5T;7!?9&%T82YU=%]I9"D**PD@(&EF("AS=')N8VUP("AI
M9"T^=71?:60L('5T;7!?9&%T82YU=%]I9"P@,BD@/3T@,"D*( D@(" @<F5T
M=7)N("9U=&UP7V1A=&$["B )("!B<F5A:SL*( ED969A=6QT.@I 0" M,C8P
M,2PT("LR-3DV+#$Y($! (&=E='5T;&EN92 H<W1R=6-T('5T;7 @*FQI;F4I
M"B )<F5T=7)N("9U=&UP7V1A=&$["B @(" @?0H@("!R971U<FX@3E5,3#L*
M*WT**PHK97AT97)N(")#(B!V;VED"BMP=71U=&QI;F4@*'-T<G5C="!U=&UP
M("IU="D**WL**R @<VEG9G)A;64@=&AI<V9R86UE("AM86EN=&AR96%D*3L*
M*R @:68@*&-H96-K7VYU;&Q?:6YV86QI9%]S=')U8W0@*'5T*2D**R @("!R
M971U<FX["BL@('-E='5T96YT("@I.PHK("!S=')U8W0@=71M<" J=3L**R @
M:68@*"AU(#T@9V5T=71I9" H=70I*2D**R @("!L<V5E:R H=71M<%]F9"P@
M+7-I>F5O9BAS=')U8W0@=71M<"DL(%-%14M?0U52*3L**R @96QS90HK(" @
M(&QS965K("AU=&UP7V9D+" P+"!3145+7T5.1"D["BL@("AV;VED*2!W<FET
M92 H=71M<%]F9"P@*&-H87(@*BD@=70L('-I>F5O9B H<W1R=6-T('5T;7 I
M*3L*('T*26YD97@Z('1T>2YC8PH]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]"E)#
M4R!F:6QE.B O8W9S+W-R8R]S<F,O=VEN<W5P+V-Y9W=I;B]T='DN8V,L=@IR
M971R:65V:6YG(')E=FES:6]N(#$N-#4*9&EF9B M=2 M<" M<C$N-#4@='1Y
M+F-C"BTM+2!T='DN8V,).2!/8W0@,C P,B P-3HU-3HT," M,# P, DQ+C0U
M"BLK*R!T='DN8V,)-B!.;W8@,C P,B R,CHP.#HP," M,# P, I 0" M.#@L
M-B K.#@L-R! 0"!C<F5A=&5?='1Y7VUA<W1E<B H:6YT('1T>6YU;2D*(" @
M(" @(&-Y9W=I;E]G971H;W-T;F%M92 H;W5R7W5T;7 N=71?:&]S="P@<VEZ
M96]F("AO=7)?=71M<"YU=%]H;W-T*2D["B @(" @("!?7W-M86QL7W-P<FEN
M=&8@*&]U<E]U=&UP+G5T7VQI;F4L(")T='DE9"(L('1T>6YU;2D["B @(" @
M("!O=7)?=71M<"YU=%]T>7!E(#T@55-%4E]04D]#15-3.PHK(" @(" @;W5R
M7W5T;7 N=71?<&ED(#T@;7ES96QF+3YP:60["B @(" @("!M>7-E;&8M/F-T
M='D@/2!T='EN=6T["B @(" @("!L;V=I;B H)F]U<E]U=&UP*3L*(" @("!]
!"@``
`
end
