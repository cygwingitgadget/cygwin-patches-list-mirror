From: "Jason Gouger" <cygwin@jason-gouger.com>
To: <cygwin-patches@sources.redhat.com>
Subject: PATCH: getcwd() pathstyle
Date: Sun, 07 Jan 2001 19:35:00 -0000
Message-id: <GIEAKOJACGCDOHKHFLIHIEIDCAAA.cygwin@jason-gouger.com>
X-SW-Source: 2001-q1/msg00012.html

Below is a small patch which adds a "pathstyle" to the CYGWIN options. This
option controls the format of the string returned by the low-level getcwd()
function.  The options are 'posix', 'win32', and 'dos'.  The 'posix' option
causes getcwd to return the traditional cygwin path, i.e. /usr/local/bin.
The 'win32' option causes getcwd to return a win32 compatible path, i.e.
C:/cygwin/usr/local/bin.  The 'dos' option causes getcwd to return a dos
compatible path, i.e. C:\cygwin\usr\local\bin.

The 'pathstyle=win32' option allows cygwin programs to more easily interact
with win32 types of programs when the cygwin program builds
arguments/envvars based off of the cwd.

Sun Jan 7 18:45:22 2001  Jason Gouger <cygwin@jason-gouger.com>

	* environ.cc: Added new configuration entry (pathstyle) to
	              'struct parse_thing .. known[]'
	* winsup.h: Added header definition for new function
	            pathstyle_start_init
	* path.cc: New function to initialize pathstyle configuration
	           named pathstyle_start_init
	           Modified 'getcwd' to return different pathstyles
	           + pathstyle=posix (default), getcwd returns
	               the traditional path, i.e. /usr/local/bin
	           + pathstyle=win32, getcwd returns a win32
	               type of path, i.e. C:/cygwin/usr/local/bin
	           + pathstyle=dos, getcwd returns a dos
	               type of path, i.e. C:\cygwin\usr\local\bin

begin 666 pathstyle.patch
M26YD97@Z(&5N=FER;VXN8V,*/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/0I20U,@
M9FEL93H@+V-V<R]S<F,O<W)C+W=I;G-U<"]C>6=W:6XO96YV:7)O;BYC8RQV
M"G)E=')I979I;F<@<F5V:7-I;VX@,2XS.0ID:69F("UP("UU("TS("UR,2XS
M.2!E;G9I<F]N+F-C"BTM+2!E;G9I<F]N+F-C"3(P,#`O,3(O,3D@,3DZ-3(Z
M-3<),2XS.0HK*RL@96YV:7)O;BYC8PDR,#`Q+S`Q+S`W(#(S.C0S.C0S"D!`
M("TT,S`L-B`K-#,P+#<@0$`@<W1R=6-T('!A<G-E7W1H:6YG"B`@('LB<W1R
M:7!?=&ET;&4B+"![)G-T<FEP7W1I=&QE7W!A=&A]+"!J=7-T<V5T+"!.54Q,
M+"![>T9!3%-%?2P@>U12545]?7TL"B`@('LB=&ET;&4B+"![)F1I<W!L87E?
M=&ET;&5]+"!J=7-T<V5T+"!.54Q,+"![>T9!3%-%?2P@>U12545]?7TL"B`@
M('LB='1Y(BP@>TY53$Q]+"!S971?<')O8V5S<U]S=&%T92P@3E5,3"P@>WLP
M?2P@>U!)1%]54T545%E]?7TL"BL@('LB<&%T:'-T>6QE(BP@>V9U;F,Z("9P
M871H<W1Y;&5?<W1A<G1?:6YI='TL(&ES9G5N8RP@3E5,3"P@>WLP?2P@>S!]
M?7TL"B`@('M.54Q,+"![,'TL(&IU<W1S970L(#`L('M[,'TL('LP?7U]"B!]
M.PH@"DEN9&5X.B!P871H+F-C"CT]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T*4D-3
M(&9I;&4Z("]C=G,O<W)C+W-R8R]W:6YS=7`O8WEG=VEN+W!A=&@N8V,L=@IR
M971R:65V:6YG(')E=FES:6]N(#$N.3$*9&EF9B`M<"`M=2`M,R`M<C$N.3$@
M<&%T:"YC8PHM+2T@<&%T:"YC8PDR,#`P+S$R+S$Y(#$Y.C4R.C4W"3$N.3$*
M*RLK('!A=&@N8V,),C`P,2\P,2\P-R`R,SHT,SHU-`I`0"`M,C4Q,RPY("LR
M-3$S+#4R($!`(&AA<VAI=#H*("`@<F5T=7)N(&AA<V@["B!]"B`**V5N=6T@
M<&%T:'-T>6QE<PHK>PHK("!P;W-I>"P**R`@=VEN,S(L"BL@(&1O<PHK?2!P
M871H<W1Y;&4@/2!P;W-I>#L**PHK97AT97)N(")#(B!V;VED"BMP871H<W1Y
M;&5?<W1A<G1?:6YI="`H8V]N<W0@8VAA<B`J8G5F*0HK>PHK("!I9B`H(6)U
M9B!\?"`A*F)U9B`I('L**R`@("!P871H<W1Y;&4@/2!P;W-I>#L**R`@?2!E
M;'-E(&EF("@A<W1R8VUP*&)U9BP@(G=I;C,R(BDI('L**R`@("!P871H<W1Y
M;&4@/2!W:6XS,CL**R`@?2!E;'-E(&EF("@A<W1R8VUP*&)U9BP@(F1O<R(I
M*2!["BL@("`@<&%T:'-T>6QE(#T@9&]S.PHK("!](&5L<V4@>PHK("`@('!A
M=&AS='EL92`]('!O<VEX.PHK("!]"BM]"BL*(&-H87(@*@H@9V5T8W=D("AC
M:&%R("IB=68L('-I>F5?="!U;&5N*0H@>PHK("!I9B`H<&%T:'-T>6QE(#T]
M('!O<VEX*2!["BL@("`@+R\@4F5T=7)N('!O<VEX('!A=&@L(&4N9RX@+W5S
M<B]B:6X**R`@("!R971U<FX@8WEG8W=D+F=E="`H8G5F+"`Q+"`Q+"!U;&5N
M*3L**R`@?0HK("!I9B`H<&%T:'-T>6QE(#T]('=I;C,R*2!["BL@("`@+R\@
M4F5T=7)N('=I;C,R('!A=&@L(&4N9RX@0SHO8WEG=VEN+W5S<B]B:6X**R`@
M("!C:&%R("IR97,["BL@("`@:68@*"AR97,@/2!C>6=C=V0N9V5T("AB=68L
M(#`L(#$L('5L96XI*2D@>PHK("`@("`@+R\@0VAA;F=E(&)A8VL@<VQA<VAE
M<R!T;R!F;W)W87)D('-L87-H97,**R`@("`@(&-H87(@*G!T<B`](')E<SL*
M*R`@("`@('=H:6QE*"`J<'1R("D@>PHK"6EF("@J<'1R(#T]("=<7"<I("IP
M='(@/2`G+R<["BL)*RMP='(["BL@("`@("!]"BL@("`@?0HK("`@(')E='5R
M;BAR97,I.PHK("!]"BL@(&EF("AP871H<W1Y;&4@/3T@9&]S*2!["BL@("`@
M+R\@4F5T=7)N(&1O<R!P871H+"!E+F<N($,Z7&-Y9W=I;EQU<W)<8FEN"BL@
M("`@<F5T=7)N(&-Y9V-W9"YG970@*&)U9BP@,"P@,2P@=6QE;BD["BL@('T*
M*R`@+R\@56YK;F]W;B!P871H<W1Y;&4L(&1E9F%U;'0@=&\@<&]S:7@*("`@
M<F5T=7)N(&-Y9V-W9"YG970@*&)U9BP@,2P@,2P@=6QE;BD["B!]"B`*26YD
M97@Z('=I;G-U<"YH"CT]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T*4D-3(&9I;&4Z
M("]C=G,O<W)C+W-R8R]W:6YS=7`O8WEG=VEN+W=I;G-U<"YH+'8*<F5T<FEE
M=FEN9R!R979I<VEO;B`Q+C0V"F1I9F8@+7`@+74@+3,@+7(Q+C0V('=I;G-U
M<"YH"BTM+2!W:6YS=7`N:`DR,#`P+S$R+S$P(#`P.C0U.C$R"3$N-#8**RLK
M('=I;G-U<"YH"3(P,#$O,#$O,#<@,C,Z-#,Z-3<*0$`@+3$X-2PV("LQ.#4L
M.2!`0"!E>'1E<FX@2$%.1$Q%(&YE=&%P:3,R7VAA;F1L93L*(&5X=&5R;B`B
M0R(@=F]I9"!E<G)O<E]S=&%R=%]I;FET("AC;VYS="!C:&%R*BD["B!E>'1E
M<FX@(D,B(&EN="!T<GE?=&]?9&5B=6<@*"D["B`**R\J(%!A=&@@<W1Y;&4@
M<W5P<&]R="X@<V5E('!A=&@N8V,Z9V5T7V-W9"@I("HO"BME>'1E<FX@(D,B
M('9O:60@<&%T:'-T>6QE7W-T87)T7VEN:70@*&-O;G-T(&-H87(J*3L**PH@
M97AT97)N(")#(B!V;VED(&-O9&5P86=E7VEN:70@*&-O;G-T(&-H87(J*3L*
L(`H@97AT97)N(&EN="!C>6=W:6Y?9FEN:7-H961?:6YI=&EA;&EZ:6YG.PH*
`
end
