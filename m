Return-Path: <cygwin-patches-return-3101-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21040 invoked by alias); 3 Nov 2002 23:59:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20888 invoked from network); 3 Nov 2002 23:59:49 -0000
Message-ID: <002701c28394$ce2fc1f0$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: fhandler_tty patch
Date: Sun, 03 Nov 2002 15:59:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00052.txt.bz2

The patch resolves -1 return value from ioctl(slave_tty, TIOCSWINSZ, ...)
problem and avoids extra SIGWINCH if the window size did not change.

2002-11-03  Sergey Okhapkin  <sos@prospect.com.ru>

        * fhandler_tty.cc (fhandler_tty_slave::ioctl): Do nothing if the new
window size is equal to the old one.
          Send SIGWINCH if slave connected to a pseudo tty.
        (fhandler_pty_master::ioctl): Do nothing if the new window size is
equal to the old one.


Sergey Okhapkin
Somerset, NJ


begin 666 fhandler_tty.diff
M26YD97@Z(&9H86YD;&5R7W1T>2YC8PH]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M"E)#4R!F:6QE.B O8W9S+W-R8R]S<F,O=VEN<W5P+V-Y9W=I;B]F:&%N9&QE
M<E]T='DN8V,L=@IR971R:65V:6YG(')E=FES:6]N(#$N-S8*9&EF9B M=2 M
M<" M<C$N-S8@9FAA;F1L97)?='1Y+F-C"BTM+2!F:&%N9&QE<E]T='DN8V,)
M,C @3V-T(#(P,#(@,#0Z,34Z-3 @+3 P,# ),2XW-@HK*RL@9FAA;F1L97)?
M='1Y+F-C"3,@3F]V(#(P,#(@,C,Z,S4Z-#,@+3 P,# *0$ @+3DU-2PQ,B K
M.34U+#(S($! (&9H86YD;&5R7W1T>5]S;&%V93HZ:6]C=&P@*'5N<VEG;F5D
M(&EN=" *(" @(" @(&=E=%]T='EP("@I+3YW:6YS:7IE(#T@9V5T7W1T>7 @
M*"DM/F%R9RYW:6YS:7IE.PH@(" @(" @8G)E86L["B @(" @8V%S92!424]#
M4U=)3E-:.@HM(" @(" @9V5T7W1T>7 @*"DM/FEO8W1L7W)E='9A;" ]("TQ
M.PHM(" @(" @9V5T7W1T>7 @*"DM/F%R9RYW:6YS:7IE(#T@*B H<W1R=6-T
M('=I;G-I>F4@*BD@87)G.PHM(" @(" @:68@*&EO8W1L7W)E<75E<W1?979E
M;G0I"BT)4V5T179E;G0@*&EO8W1L7W)E<75E<W1?979E;G0I.PHM(" @(" @
M:68@*&EO8W1L7V1O;F5?979E;G0I"BT)5V%I=$9O<E-I;F=L94]B:F5C=" H
M:6]C=&Q?9&]N95]E=F5N="P@24Y&24Y)5$4I.PHK(" @(" @:68@*&=E=%]T
M='EP("@I+3YW:6YS:7IE+G=S7W)O=R A/2 H*'-T<G5C="!W:6YS:7IE("HI
M(&%R9RDM/G=S7W)O=PHK"2 @?'P@9V5T7W1T>7 @*"DM/G=I;G-I>F4N=W-?
M8V]L("$]("@H<W1R=6-T('=I;G-I>F4@*BD@87)G*2T^=W-?8V]L*0HK(" @
M(" @("!["BL@(" @(" @(" @9V5T7W1T>7 @*"DM/F%R9RYW:6YS:7IE(#T@
M*B H<W1R=6-T('=I;G-I>F4@*BD@87)G.PHK(" @(" @(" @(&EF("AI;V-T
M;%]R97%U97-T7V5V96YT*0HK"2 @("!["BL@(" @(" @(" @(" @(&=E=%]T
M='EP("@I+3YI;V-T;%]R971V86P@/2 M,3L**PD@(" @("!3971%=F5N=" H
M:6]C=&Q?<F5Q=65S=%]E=F5N="D["BL)(" @('T**PD@(&5L<V4**PD@(" @
M>PHK"2 @(" @(&=E=%]T='EP("@I+3YW:6YS:7IE(#T@*B H<W1R=6-T('=I
M;G-I>F4@*BD@87)G.PHK"2 @(" @(&MI;&P@*"UG971?='1Y<" H*2T^9V5T
M<&=I9" H*2P@4TE'5TE.0T@I.PHK"2 @("!]"BL@(" @(" @(" @:68@*&EO
M8W1L7V1O;F5?979E;G0I"BL)(" @(%=A:71&;W)3:6YG;&5/8FIE8W0@*&EO
M8W1L7V1O;F5?979E;G0L($E.1DE.251%*3L**PE]"B @(" @("!B<F5A:SL*
M(" @("!]"B *0$ @+3$Q,#,L." K,3$Q-"PQ,B! 0"!F:&%N9&QE<E]P='E?
M;6%S=&5R.CII;V-T;" H=6YS:6=N960@:6YT"B )*B H<W1R=6-T('=I;G-I
M>F4@*BD@87)G(#T@9V5T7W1T>7 @*"DM/G=I;G-I>F4["B )8G)E86L["B @
M(" @("!C87-E(%1)3T-35TE.4UHZ"BT)9V5T7W1T>7 @*"DM/G=I;G-I>F4@
M/2 J("AS=')U8W0@=VEN<VEZ92 J*2!A<F<["BT):VEL;" H+6=E=%]T='EP
M("@I+3YG971P9VED("@I+"!324=724Y#2"D["BL@(" @(" @(&EF("AG971?
M='1Y<" H*2T^=VEN<VEZ92YW<U]R;W<@(3T@*"AS=')U8W0@=VEN<VEZ92 J
M*2!A<F<I+3YW<U]R;W<**PD@(" @?'P@9V5T7W1T>7 @*"DM/G=I;G-I>F4N
M=W-?8V]L("$]("@H<W1R=6-T('=I;G-I>F4@*BD@87)G*2T^=W-?8V]L*0HK
M(" @(" @(" @('L**PD@(" @9V5T7W1T>7 @*"DM/G=I;G-I>F4@/2 J("AS
M=')U8W0@=VEN<VEZ92 J*2!A<F<["BL)(" @(&MI;&P@*"UG971?='1Y<" H
M*2T^9V5T<&=I9" H*2P@4TE'5TE.0T@I.PHK"2 @?0H@"6)R96%K.PH@(" @
M(" @8V%S92!&24].0DE/.@H@"7-E=%]N;VYB;&]C:VEN9R H*BAI;G0@*BD@
&87)G*3L*
`
end
