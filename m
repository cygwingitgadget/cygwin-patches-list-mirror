From: Egor Duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: fhandler_console
Date: Wed, 28 Feb 2001 10:54:00 -0000
Message-id: <109112986916.20010228215037@logos-m.ru>
References: <16286062992.20010216183758@logos-m.ru> <20010219214951.A23483@redhat.com> <7888578378.20010220130012@logos-m.ru> <17613156858.20010223151715@logos-m.ru> <20010226191432.E6209@redhat.com> <20010228182620.R8464@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00129.html
Content-type: multipart/mixed; boundary="----------=_1583532846-65438-16"

This is a multi-part message in MIME format...

------------=_1583532846-65438-16
Content-length: 1148

Hi!

Wednesday, 28 February, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:

CV> your patch seems to have some problems on the local console window
CV> at least on W2K.

CV> When I open a console window with

CV> tcsh, CYGWIN=tty: Only the first line is used at all. The background
CV>                   color of the prompt is correct, behind the cursor
CV>                   it's inverted.

CV> bash, CYGWIN=tty: The first line is inverted, no cursor, no interaction.

CV> tcsh, CYGWIN=notty: Crash, ia message box tells me that an instruction
CV>                     at address x61061d48 points to 0x00000068.

CV> bash, CYGWIN=notty: Same behaviour as tcsh with CYGWIN=tty, really!

CV> When I revert the patch to fhandler_console.cc, everything is ok.

hmm.  i  cannot test in on win2k right now, but can you please test it
with  attached terminfo entry? Would you mind sending me bash and tcsh
rc  files?  both  bash  and tcsh works ok for me in both tty and notty
mode,  and  all programs from 'test/' directory in ncurses source tree
worked fine too.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
cygwin


------------=_1583532846-65438-16
Content-Type: application/x-terminfo; charset=binary; name="cygwin"
Content-Disposition: inline; filename="cygwin"
Content-Transfer-Encoding: base64
Content-Length: 2038

GgEhABUAEABpAasCY3lnd2lufGFuc2kgZW11bGF0aW9uIGZvciBDeWd3aW4A
AAEAAAABAAAAAAAAAAEBAAAAAAABUAAIABgA////////////////////////
//8IAEAAAwAAAAQABgD//wgADQAUABgAHAD//ycAOAA8AP//QAD//0QASwD/
/08A//9TAFcA/////1sA//9hAP////9mAGsAcAD//3UAegB/AP//hACKAP//
//+PAJQAmgCgAP///////////////7IAtgD//7oA////////vAD//8EA////
///////FAMoA0ADVANoA3wDkAOoA8AD2APwAAQH//wYB//8KAQ8BFAH/////
//8YAf///////////////////////////////////////xwB//8fASgBMQE6
Af//QwFMAVUB//9eAf//////////////////ZwH///////9tAXABewF+AYAB
gwHWAf//2QH////////////////bAf//////////3wH//x4C////////////
////////////////////////////IgL/////////////////////////////
/////////////////////ycC////////////////////////////////////
//////////////8pAv//LgL///////////////////////8zAjkCPwJFAksC
UQJXAl0CYwJpAv//////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////bwL/////////////////////////////////////////////////
////////////dAJ/AoQCigKOAv//////////////////////////////////
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
////////lwKhAhtbWgAHAA0AG1syZwAbW0gbW0oAG1tLABtbSgAbWyVpJXAx
JWRHABtbJWklcDElZDslcDIlZEgAG1tCABtbSAAbW0QAG1s/MjVoABtbQwAb
W0EAG1tQABtbTQAbWzExbQAbWzFtABtbMm0AG1s0aAAbWzhtABtbN20AG1s3
bQAbWzRtABtbMTBtABtbMG0AG1s0bAAbWzI3bQAbWzI0bQAbWz81aBtbPzVs
JDwyMDAvPgAbW0AAG1tMAAgAG1szfgAbW0IAG1tbQQAbWzIxfgAbW1tCABtb
W0MAG1tbRAAbW1tFABtbMTd+ABtbMTh+ABtbMTl+ABtbMjB+ABtbMX4AG1sy
fgAbW0QAG1s2fgAbWzV+ABtbQwAbW0EADQoAG1slcDElZFAAG1slcDElZE0A
G1slcDElZEIAG1slcDElZEAAG1slcDElZEwAG1slcDElZEQAG1slcDElZEMA
G1slcDElZEEAG2MbXVIAGzgAG1slaSVwMSVkZAAbNwAKABtNABtbMCU/JXAx
JXQ7NyU7JT8lcDIldDs0JTslPyVwMyV0OzclOyU/JXA0JXQ7NSU7JT8lcDYl
dDsxJTslPyVwNyV0OzglOyU/JXA5JXQ7MTElO20AG0gACQAbW0cAKxAsES0Y
Lhkw22AEYbFm+GfxaLBq2Wu/bNptwG7Fb35wxHHEcsRzX3TDdbR2wXfCeLN5
83rye+N82H2cfv4AG1taABtbNH4AGgAbWzYkABtbNSQAG1syM34AG1syNH4A
G1syNX4AG1syNn4AG1syOH4AG1syOX4AG1szMX4AG1szMn4AG1szM34AG1sz
NH4AG1sxSwAbWyVpJWQ7JWRSABtbNm4AG1s/NmMAG1tjABtbMzk7NDltABtb
MyVwMSVkbQAbWzQlcDElZG0A

------------=_1583532846-65438-16--
