Return-Path: <cygwin-patches-return-3123-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 723 invoked by alias); 5 Nov 2002 21:56:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 710 invoked from network); 5 Nov 2002 21:56:34 -0000
Message-ID: <007901c28515$e66596a0$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Cygwin-Patches" <cygwin-patches@cygwin.com>
Subject: More fhandler_serial fixes.
Date: Tue, 05 Nov 2002 13:56:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00074.txt.bz2

The patch fixes sume bugs/typos in fhandler_serial

2002-11-03  Sergey Okhapkin  <sos@prospect.com.ru>

        * fhandler_serial.cc (fhandler_serial::raw_read): Use correct type,
fix typo.
        (fhandler_serial::ioctl): Fix ClearCommError() return value check,
         set errno if the call failed.
         Don't give up if DeviceIoCtl() failed, but fall back to Win95
method.
        (fhandler_serial::tcsetattr): Use correct value for vmin_.
        (fhandler_serial::tcgetattr): Ditto.

Sergey Okhapkin
Somerset, NJ


begin 666 fhandler_serial.cc.diff
M26YD97@Z(&9H86YD;&5R7W-E<FEA;"YC8PH]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]"E)#4R!F:6QE.B O8W9S+W-R8R]S<F,O=VEN<W5P+V-Y9W=I;B]F:&%N
M9&QE<E]S97)I86PN8V,L=@IR971R:65V:6YG(')E=FES:6]N(#$N,S(*9&EF
M9B M=2 M<" M<C$N,S(@9FAA;F1L97)?<V5R:6%L+F-C"BTM+2!F:&%N9&QE
M<E]S97)I86PN8V,)-"!.;W8@,C P,B P-#HP.3HQ-" M,# P, DQ+C,R"BLK
M*R!F:&%N9&QE<E]S97)I86PN8V,)-2!.;W8@,C P,B R,3HT-3HU,B M,# P
M, I 0" M-#,L-R K-#,L-R! 0"!F:&%N9&QE<E]S97)I86PZ.G)A=U]R96%D
M("AV;VED("IP='(L('-I"B @(&EN="!T;W0["B @($173U)$(&X["B @($A!
M3D1,12!W-%LR73L*+2 @1%=/4D0@;6EN8VAA<G,@/2!V;6EN7R _.B!U;&5N
M.PHK("!S:7IE7W0@;6EN8VAA<G,@/2!V;6EN7R _=FUI;E\Z('5L96X["B *
M(" @=S1;,%T@/2!I;U]S=&%T=7,N:$5V96YT.PH@("!W-%LQ72 ]('-I9VYA
M;%]A<G)I=F5D.PI 0" M,S@W+#@@*S,X-RPQ,2! 0"!F:&%N9&QE<E]S97)I
M86PZ.FEO8W1L("AU;G-I9VYE9"!I;G0@8VUD"B *(" @1%=/4D0@978["B @
M($-/35-4050@<W0["BT@(&EF("A#;&5A<D-O;6U%<G)O<B H9V5T7VAA;F1L
M92 H*2P@)F5V+" F<W0I*0HM(" @(')E<R ]("TQ.PHK("!I9B H0VQE87)#
M;VUM17)R;W(@*&=E=%]H86YD;&4@*"DL("9E=BP@)G-T*2 ]/2 P*0HK(" @
M('L**R @(" @(%]?<V5T97)R;F\@*"D["BL@(" @("!R97,@/2 M,3L**R @
M("!]"B @(&5L<V4*(" @("!S=VET8V@@*&-M9"D*(" @(" @('L*0$ @+30R
M,RPR," K-#(V+#(Q($! (&9H86YD;&5R7W-E<FEA;#HZ:6]C=&P@*'5N<VEG
M;F5D(&EN="!C;60*( D)"0D)(" @(" @(# L("9M8W(L(#0L("9C8BP@,"D[
M"B )"6EF("@A<F5S=6QT*0H@"0D@('L*+0D)(" @(%]?<V5T97)R;F\@*"D[
M"BT)"2 @("!R97,@/2 M,3L*+0D)(" @(&=O=&\@;W5T.PHK"0D@(" @;6]D
M96U?<W1A='5S('P](')T<R!\(&1T<CL*( D)("!]"BT)"6EF("AC8B A/2 T
M*0HK"0EE;'-E"B )"2 @>PHM"0D@(" @<V5T7V5R<FYO("A%24Y604PI.PDO
M*B!&25A-13H@<FEG:'0@97)R;F\_("HO"BT)"2 @("!R97,@/2 M,3L*+0D)
M(" @(&=O=&\@;W5T.PHK"0D@(" @:68@*&-B("$](#0I"BL)"2 @(" @('L*
M*PD)(" @(" @("!S971?97)R;F\@*$5)3E9!3"D["2\J($9)6$U%.B!R:6=H
M="!E<G)N;S\@*B\**PD)(" @(" @("!R97,@/2 M,3L**PD)(" @(" @("!G
M;W1O(&]U=#L**PD)(" @(" @?0HK"0D@(" @:68@*&UC<B F(#(I"BL)"2 @
M(" @(&UO9&5M7W-T871U<R!\/2!424]#35]25%,["BL)"2 @("!I9B H;6-R
M("8@,2D**PD)(" @(" @;6]D96U?<W1A='5S('P](%1)3T--7T144CL*( D)
M("!]"BT)"6EF("AM8W(@)B R*0HM"0D@(&UO9&5M7W-T871U<R!\/2!424]#
M35]25%,["BT)"6EF("AM8W(@)B Q*0HM"0D@(&UO9&5M7W-T871U<R!\/2!4
M24]#35]$5%(["B )(" @(" @?0H@"2 @("!I<&)U9F9E<B ](&UO9&5M7W-T
M871U<SL*( D@('T*0$ @+3<Y-"PW("LW.3@L-R! 0"!F:&%N9&QE<E]S97)I
M86PZ.G1C<V5T871T<B H:6YT(&%C=&EO;BP@"B *(" @:68@*'0M/F-?;&9L
M86<@)B!)0T%.3TXI"B @(" @>PHM(" @(" @=FUI;E\@/2!-05A$5T]21#L*
M*R @(" @('9M:6Y?(#T@,#L*(" @(" @('9T:6UE7R ](# ["B @(" @?0H@
M("!E;'-E"D! ("TY.3DL-R K,3 P,RPW($! (&9H86YD;&5R7W-E<FEA;#HZ
M=&-G971A='1R("AS=')U8W0@=&5R;6D*(" @("!T+3YC7V]F;&%G('P]($].
M3$-2.PH@"B @(&1E8G5G7W!R:6YT9B H(G9M:6Y?("5D+"!V=&EM95\@)60B
M+"!V;6EN7RP@=G1I;65?*3L*+2 @:68@*'9M:6Y?(#T]($U!6$173U)$*0HK
M("!I9B H=FUI;E\@/3T@,"D*(" @("!["B @(" @("!T+3YC7VQF;&%G('P]
M($E#04Y/3CL*(" @(" @('0M/F-?8V-;5E1)345=(#T@="T^8U]C8UM634E.
'72 ](# ["@``
`
end
