From: Yukihiko Sohda <sohda@is.titech.ac.jp>
To: cygwin-patches@cygwin.com
Subject: tiny patch for setup.exe
Date: Sat, 26 May 2001 02:20:00 -0000
Message-id: <20010526181011.5457.SOHDA@is.titech.ac.jp>
X-SW-Source: 2001-q2/msg00266.html

Hi,

Current setup.exe can't parse `+' character in setup.ini.

# for gtk+ ?

--- inilex.l.orig       Sat May 26 18:08:33 2001
+++ inilex.l    Fri May 25 02:09:44 2001
@@ -36,7 +36,7 @@ static void ignore_line ();
 %option yylineno
 %option never-interactive

-STR    [a-zA-Z0-9_./-]+
+STR    [a-zA-Z0-9_./+-]+

 %%

----
Yukihiko Sohda <sohda@is.titech.ac.jp>
