Return-Path: <cygwin-patches-return-1525-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 32665 invoked by alias); 27 Nov 2001 17:48:51 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 32581 invoked from network); 27 Nov 2001 17:48:47 -0000
Message-ID: <001b01c1776b$0ad3c020$02af6080@cc.telcordia.com>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-patches@sourceware.cygnus.com>
Subject: shutdown sockets on exit patch
Date: Wed, 17 Oct 2001 02:13:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-SW-Source: 2001-q4/txt/msg00057.txt.bz2

Hi!

The patch attached implements gracefull socket shutdown on application exit.
Rexecd from inetutils package do not print an annoying message now. Corinna,
I didn't test the fix with rshd, test it please!

dcrt0.cc          (do_exit): call close_all_files() with "true" argument.

dtable.cc        (vfork_parent_restore): call close_all_files with "false"
argument.

fhandler.h        (class fhandler_base, class fhandler_socket): new virtual
method atexit().

fhandler_socket.cc    (fhandler_socket::atexit): New. Call shutdown() to
terminate the connection.

spawn.cc        (spawn_guts): call close_all_files with "false" argument.

syscalls.cc     (close_all_files): call fhandler's atexit() method on
process exit.

winsup.h         (close_all_files): change prototype.

Sergey Okhapkin
Piscataway, NJ


begin 666 shutdown.diff
M26YD97@Z(&1C<G0P+F-C"CT]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T*4D-3(&9I
M;&4Z("]C=G,O<W)C+W-R8R]W:6YS=7 O8WEG=VEN+V1C<G0P+F-C+'8*<F5T
M<FEE=FEN9R!R979I<VEO;B Q+C$Q. ID:69F("UU("UU("UP("UR,2XQ,3@@
M9&-R=# N8V,*+2TM(&1C<G0P+F-C"3(P,#$O,3 O,34@,C,Z,SDZ,S(),2XQ
M,3@**RLK(&1C<G0P+F-C"3(P,#$O,3$O,C<@,38Z-#@Z,C(*0$ @+3DR-RPW
M("LY,C<L-R! 0"!D;U]E>&ET("AI;G0@<W1A='5S*0H@("!I9B H97AI=%]S
M=&%T92 \($537T-,3U-%04Q,*0H@(" @('L*(" @(" @(&5X:71?<W1A=&4@
M/2!%4U]#3$]314%,3#L*+2 @(" @(&-L;W-E7V%L;%]F:6QE<R H*3L**R @
M(" @(&-L;W-E7V%L;%]F:6QE<R H=')U92D["B @(" @?0H@"B @(&EF("AE
M>&ET7W-T871E(#P@15-?4TE'4%)/0U1%4DU)3D%412D*26YD97@Z(&1T86)L
M92YC8PH]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]"E)#4R!F:6QE.B O8W9S+W-R
M8R]S<F,O=VEN<W5P+V-Y9W=I;B]D=&%B;&4N8V,L=@IR971R:65V:6YG(')E
M=FES:6]N(#$N-S *9&EF9B M=2 M=2 M<" M<C$N-S @9'1A8FQE+F-C"BTM
M+2!D=&%B;&4N8V,),C P,2\Q,2\R-" P,SHQ,3HS.0DQ+C<P"BLK*R!D=&%B
M;&4N8V,),C P,2\Q,2\R-R Q-CHT.#HR,@I 0" M-3DP+#<@*S4Y,"PW($! 
M(&1T86)L93HZ=F9O<FM?<&%R96YT7W)E<W1O<F4@*"D*('L*(" @4V5T4F5S
M;W5R8V5,;V-K("A,3T-+7T9$7TQ)4U0L(%=2251%7TQ/0TL@?"!214%$7TQ/
M0TLL(")R97-T;W)E(BD["B *+2 @8VQO<V5?86QL7V9I;&5S("@I.PHK("!C
M;&]S95]A;&Q?9FEL97,@*&9A;'-E*3L*(" @9FAA;F1L97)?8F%S92 J*F1E
M;&5T96UE(#T@9F1S.PH@("!A<W-E<G0@*&9D<U]O;E]H;VQD("$]($Y53$PI
M.PH@("!F9',@/2!F9'-?;VY?:&]L9#L*26YD97@Z(&9H86YD;&5R+F@*/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/0I20U,@9FEL93H@+V-V<R]S<F,O<W)C+W=I
M;G-U<"]C>6=W:6XO9FAA;F1L97(N:"QV"G)E=')I979I;F<@<F5V:7-I;VX@
M,2XQ,#,*9&EF9B M=2 M=2 M<" M<C$N,3 S(&9H86YD;&5R+F@*+2TM(&9H
M86YD;&5R+F@),C P,2\Q,2\R-" P,SHQ,3HS.0DQ+C$P,PHK*RL@9FAA;F1L
M97(N: DR,# Q+S$Q+S(W(#$V.C0X.C(R"D! ("TQ-C,L-B K,38S+#<@0$ @
M8VQA<W,@9FAA;F1L97)?8F%S90H@("!$5T]21"!G971?9&5V:6-E("@I('L@
M<F5T=7)N('-T871U<R F($9(7T1%5DU!4TL[('T*(" @=FER='5A;"!I;G0@
M9V5T7W5N:70@*"D@>R!R971U<FX@,#L@?0H@("!V:7)T=6%L($)/3TP@:7-?
M<VQO=R H*2![(')E='5R;B!G971?9&5V:6-E("@I(#P@1DA?4TQ/5SL@?0HK
M("!V:7)T=6%L('9O:60@871E>&ET("@I('L@<F5T=7)N.R!]"B *(" @:6YT
M(&=E=%]A8V-E<W,@*"D@>R!R971U<FX@86-C97-S.R!]"B @('9O:60@<V5T
M7V%C8V5S<R H:6YT('@I('L@86-C97-S(#T@>#L@?0I 0" M,S<R+#8@*S,W
M,RPW($! (&-L87-S(&9H86YD;&5R7W-O8VME=#H@<'5B;&EC(&9H86YD;&5R
M7V(*( H@("!V;VED('-E=%]S:'5T9&]W;E]R96%D("@I('M&2%-%5$8@*%-(
M55121"D[?0H@("!V;VED('-E=%]S:'5T9&]W;E]W<FET92 H*2![1DA3151&
M("A32%545U(I.WT**R @=F]I9"!A=&5X:70@*"D["B *(" @:6YT('=R:71E
M("AC;VYS="!V;VED("IP='(L('-I>F5?="!L96XI.PH@("!I;G0@7U]S=&1C
M86QL(')E860@*'9O:60@*G!T<BP@<VEZ95]T(&QE;BD@7U]A='1R:6)U=&5?
M7R H*')E9W!A<FT@*#,I*2D["DEN9&5X.B!F:&%N9&QE<E]S;V-K970N8V,*
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/0I20U,@9FEL93H@+V-V<R]S<F,O<W)C
M+W=I;G-U<"]C>6=W:6XO9FAA;F1L97)?<V]C:V5T+F-C+'8*<F5T<FEE=FEN
M9R!R979I<VEO;B Q+C,V"F1I9F8@+74@+74@+7 @+7(Q+C,V(&9H86YD;&5R
M7W-O8VME="YC8PHM+2T@9FAA;F1L97)?<V]C:V5T+F-C"3(P,#$O,3$O,#4@
M,#8Z,#DZ,#<),2XS-@HK*RL@9FAA;F1L97)?<V]C:V5T+F-C"3(P,#$O,3$O
M,C<@,38Z-#@Z,C(*0$ @+3(W,RPV("LR-S,L,34@0$ @9FAA;F1L97)?<V]C
M:V5T.CIW<FET92 H8V]N<W0@=F]I9" J<'1R+ H@("!R971U<FX@<F5S.PH@
M?0H@"BL**R\J($-Y9W=I;B!I;G1E<FYA;" J+PHK=F]I9 HK9FAA;F1L97)?
M<V]C:V5T.CIA=&5X:70@*"D**WL**R @<VAU=&1O=VX@*&=E=%]S;V-K970@
M*"DL(%-$7T)/5$@I.PHK?0HK"BL*("\J($-Y9W=I;B!I;G1E<FYA;" J+PH@
M:6YT"B!F:&%N9&QE<E]S;V-K970Z.F-L;W-E("@I"DEN9&5X.B!S<&%W;BYC
M8PH]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]"E)#4R!F:6QE.B O8W9S+W-R8R]S
M<F,O=VEN<W5P+V-Y9W=I;B]S<&%W;BYC8RQV"G)E=')I979I;F<@<F5V:7-I
M;VX@,2XY- ID:69F("UU("UU("UP("UR,2XY-"!S<&%W;BYC8PHM+2T@<W!A
M=VXN8V,),C P,2\Q,2\P-2 P-CHP.3HP. DQ+CDT"BLK*R!S<&%W;BYC8PDR
M,# Q+S$Q+S(W(#$V.C0X.C(S"D! ("TW-C$L-R K-S8Q+#<@0$ @<W!A=VY?
M9W5T<R H2$%.1$Q%(&A4;VME;BP@8V]N<W0@8VAA<B J( H@(" @(" @<W1R
M86-E+F5X96-I;F<@/2 Q.PH@(" @(" @:$5X96-E9" ]('!I+FA0<F]C97-S
M.PH@(" @(" @<W1R8W!Y("AM>7-E;&8M/G!R;V=N86UE+"!R96%L7W!A=&@I
M.PHM(" @(" @8VQO<V5?86QL7V9I;&5S("@I.PHK(" @(" @8VQO<V5?86QL
M7V9I;&5S("AF86QS92D["B @(" @?0H@("!E;'-E"B @(" @>PI);F1E>#H@
M<WES8V%L;',N8V,*/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/0I20U,@9FEL93H@
M+V-V<R]S<F,O<W)C+W=I;G-U<"]C>6=W:6XO<WES8V%L;',N8V,L=@IR971R
M:65V:6YG(')E=FES:6]N(#$N,3<U"F1I9F8@+74@+74@+7 @+7(Q+C$W-2!S
M>7-C86QL<RYC8PHM+2T@<WES8V%L;',N8V,),C P,2\Q,2\Q-2 P,SHR-3HU
M,@DQ+C$W-0HK*RL@<WES8V%L;',N8V,),C P,2\Q,2\R-R Q-CHT.#HR,PI 
M0" M-#DL-R K-#DL-R! 0"!365-414U?24Y&3R!S>7-T96U?:6YF;SL*(" @
M(&5N<W5R92!W92!D;VXG="!L96%V92!A;GD@<W5C:"!F:6QE<R!L>6EN9R!A
M<F]U;F0N(" J+PH@"B!V;VED(%]?<W1D8V%L; HM8VQO<V5?86QL7V9I;&5S
M("AV;VED*0HK8VQO<V5?86QL7V9I;&5S("AB;V]L(&5X:70I"B!["B @(%-E
M=%)E<V]U<F-E3&]C:R H3$]#2U]&1%],25-4+"!74DE415],3T-+('P@4D5!
M1%],3T-++" B8VQO<V5?86QL7V9I;&5S(BD["B *0$ @+34W+#8@*S4W+#@@
M0$ @8VQO<V5?86QL7V9I;&5S("AV;VED*0H@("!F;W(@*&EN="!I(#T@,#L@
M:2 \("AI;G0I(&-Y9VAE87 M/F9D=&%B+G-I>F4[(&DK*RD*(" @("!I9B H
M*&9H(#T@8WEG:&5A<"T^9F1T86);:5TI("$]($Y53$PI"B @(" @("!["BL)
M:68@*&5X:70I"BL)"69H+3YA=&5X:70H*3L*( EF:"T^8VQO<V4@*"D["B )
M8WEG:&5A<"T^9F1T86(N<F5L96%S92 H:2D["B @(" @("!]"DEN9&5X.B!W
M:6YS=7 N: H]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]"E)#4R!F:6QE.B O8W9S
M+W-R8R]S<F,O=VEN<W5P+V-Y9W=I;B]W:6YS=7 N:"QV"G)E=')I979I;F<@
M<F5V:7-I;VX@,2XW.0ID:69F("UU("UU("UP("UR,2XW.2!W:6YS=7 N: HM
M+2T@=VEN<W5P+F@),C P,2\Q,2\R-" R,3HQ,#HP, DQ+C<Y"BLK*R!W:6YS
M=7 N: DR,# Q+S$Q+S(W(#$V.C0X.C(T"D! ("TQ-#(L-R K,30R+#<@0$ @
M=F]I9"!U:6YF;U]I;FET("AV;VED*3L*('9O:60@979E;G1S7VEN:70@*'9O
M:60I.PH@=F]I9"!E=F5N='-?=&5R;6EN871E("AV;VED*3L*( HM=F]I9"!?
M7W-T9&-A;&P@8VQO<V5?86QL7V9I;&5S("AV;VED*3L**W9O:60@7U]S=&1C
M86QL(&-L;W-E7V%L;%]F:6QE<R H8F]O;"D["B!"3T],(%]?<W1D8V%L;"!C
M:&5C:U]P='E?9F1S("AV;VED*3L*( H@+RH@26YV:7-I8FQE('=I;F1O=R!I
>;FET:6%L:7IA=&EO;B]T97)M:6YA=&EO;BX@*B\*
`
end
