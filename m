From: "Edward M. Lee" <edward@tailifer.com>
To: "List, Cygwin Developers" <cygwin-developers@cygwin.com>
Cc: "List, Cygwin Patches" <cygwin-patches@cygwin.com>
Subject: Minor winsup/doc/sgml patch.
Date: Thu, 21 Dec 2000 12:07:00 -0000
Message-id: <FMEOJCMLNIMPBKAPFPIHCEPICFAA.edward@tailifer.com>
X-SW-Source: 2000-q4/msg00053.html

Just some things to make the sgml conformant.

ChangeLog:

Thu Dec 21 15:03:29 2000  Edward M. Lee <tailbert@yahoo.com>

	* cygwinenv.sgml: Fix typo in <filename>. Add missing </para>.


--- doc/cygwinenv.sgml~ Thu Dec 21 15:01:14 2000
+++ doc/cygwinenv.sgml Thu Dec 21 14:52:16 2000
@@ -1,4 +1,3 @@
-cvs -d :pserver:anoncvs@anoncvs.cygnus.com:/cvs/src co -p
src/winsup/doc/cygwinenv.sgml
 <sect1 id="using-cygwinenv"><title>The <EnVar>CYGWIN</EnVar> environment
 variable</title>

@@ -30,10 +29,10 @@
 settings are re-exported to the environment as $CYGWIN again.</para>
 </listitem>
 <listitem>
-<para><FirstTerm>error_start:filepath</FirstTerm> - if set, runs
<filename>filepath</filepath>
+<para><FirstTerm>error_start:filepath</FirstTerm> - if set, runs
<filename>filepath</filename>
 when cygwin encounters a fatal error.  This is useful for debugging.
 <filename>filepath</filename> is usually set to the path to the
<filename>gdb</filename>
-program.
+program.</para>
 <para><FirstTerm>(no)glob[:ignorecase]</FirstTerm> - if set, command line
arguments
 containing UNIX-style file wildcard characters (brackets, question mark,
 asterisk, escaped with \) are expanded into lists of files that match
