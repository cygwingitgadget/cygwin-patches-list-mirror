Return-Path: <cygwin-patches-return-4603-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25644 invoked by alias); 12 Mar 2004 13:56:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25634 invoked from network); 12 Mar 2004 13:56:58 -0000
content-class: urn:content-classes:message
Subject: Patch for /proc/meminfo handler
Date: Fri, 12 Mar 2004 13:56:00 -0000
Message-ID: <A065B7C9B0648F4F8C43388D0D699F8D1DBEEC@ZABRYSVCL21EX01.af.didata.local>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
From: "Andrew Klopper" <andrew.klopper@is.co.za>
To: <cygwin-patches@cygwin.com>
X-OriginalArrivalTime: 12 Mar 2004 13:14:10.0963 (UTC) FILETIME=[E8762E30:01C40833]
X-SW-Source: 2004-q1/txt/msg00093.txt.bz2

With the Cygwin 1.5.7-1 DLL, 'cat /proc/meminfo' returns an incorrect
value for free swap space. This is most noticeable when the free virtual
memory is less than the total physical memory, in which case the
calculated free swap space is a negative value. This value is then
converted to an unsigned int for display purposes, resulting in a very
large positive number which is greater than the total amount of swap
space.

A patch to correct this problem is attached.

Regards
Andrew
 <<fhandler_proc.cc.diff>> 
-- 
Andrew Klopper                    andrew.klopper@za.didata.com
Dimension Data PLC                Tel: +27-11-575-1424
Johannesburg, South Africa        Fax: +27-11-576-1424






This email and all contents are subject to the following disclaimer:

"http://www.didata.com/disclaimer.asp"

begin 666 fhandler_proc.cc.diff
M+2TM(&9H86YD;&5R7W!R;V,N8V,N;W)I9PDR,# S+3$Q+3(V(# T.C$U.C W
M+C P,3 P,# P," K,#(P, T**RLK(&9H86YD;&5R7W!R;V,N8V,),C P-"TP
M,RTQ,2 Q-3HT,CHR,2XW,S$V,S@Q,# @*S R,# -"D! ("TS.3$L-R K,SDQ
M+#<@0$ -"B @(&UE;5]T;W1A;" ](&UE;6]R>5]S=&%T=7,N9'=4;W1A;%!H
M>7,[#0H@("!M96U?9G)E92 ](&UE;6]R>5]S=&%T=7,N9'=!=F%I;%!H>7,[
M#0H@("!S=V%P7W1O=&%L(#T@;65M;W)Y7W-T871U<RYD=U1O=&%L4&%G949I
M;&4@+2!M96U?=&]T86P[#0HM("!S=V%P7V9R964@/2!M96UO<GE?<W1A='5S
M+F1W079A:6Q086=E1FEL92 M(&UE;5]T;W1A;#L-"BL@('-W87!?9G)E92 ]
M(&UE;6]R>5]S=&%T=7,N9'=!=F%I;%!A9V5&:6QE("T@;65M7V9R964[#0H@
M("!R971U<FX@7U]S;6%L;%]S<')I;G1F("AD97-T8G5F+" B(" @(" @(" @
M=&]T86PZ(" @(" @=7-E9#H@(" @("!F<F5E.EQN(@T*( D)"0D@(" B365M
M.B @)3$P;'4@)3$P;'4@)3$P;'5<;B(-"B )"0D)(" @(E-W87 Z("4Q,&QU
1("4Q,&QU("4Q,&QU7&XB#0H`
`
end
