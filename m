Return-Path: <cygwin-patches-return-3662-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11817 invoked by alias); 1 Mar 2003 17:32:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11807 invoked from network); 1 Mar 2003 17:32:41 -0000
Date: Sat, 01 Mar 2003 17:32:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
To: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>, cygwin-patches@cygwin.com
Subject: Re: utils.sgml (was Re: mkpasswd & mkgroup)
Message-ID: <20030301173231.GA1244@world-gov>
References: <3.0.5.32.20030224232915.007f5530@mail.attbi.com> <3.0.5.32.20030301114320.007ecc20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030301114320.007ecc20@incoming.verizon.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00311.txt.bz2


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 261

> At 02:45 PM 2/25/2003 -0800, Joshua Daniel Franklin wrote:
> >Any progress on documenting these in utils.sgml?
 
On Sat, Mar 01, 2003 at 11:43:20AM -0500, Pierre A. Humblet wrote:
> Yes!

Thanks Pierre! I checked this in with only a small grammatical
change.

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="utils.sgml-patch"
Content-length: 7265

? utils.sgml-orig
? utils.sgml-patch
Index: utils.sgml
===================================================================
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v
retrieving revision 1.35
diff -h -u -p -r1.35 utils.sgml
--- utils.sgml	3 Feb 2003 00:30:45 -0000	1.35
+++ utils.sgml	1 Mar 2003 17:28:37 -0000
@@ -372,6 +372,7 @@ This program prints a /etc/group file to
 
 Options:
    -l,--local             print local group information
+   -c,--current           print current group, if a domain account
    -d,--domain            print global group information from the domain
                           specified (or from the current domain if there is
                           no domain specified)
@@ -389,14 +390,15 @@ One of `-l' or `-d' must be given on NT/
 
 <para>The <command>mkgroup</command> program can be used to help
 configure your Windows system to be more UNIX-like by creating an
-initial <filename>/etc/group</filename> substitute (some commands need this
-file) from your system information. It only works on the NT series
-(Windows NT, 2000, and XP). <command>mkgroup</command> does not work on 
-the Win9x series (Windows 95, 98, and Me) because they lack the security model 
-to support it. To initially set up your machine, you'd do something like 
-this:</para>
-
-<example><title>Setting up the groups file</title>
+initial <filename>/etc/group</filename>.
+Its use is essential on the NT series (Windows NT, 2000, and XP) to
+include Windows security information.
+It can also be used on the Win9x series (Windows 95, 98, and Me) to
+create a file with the correct format.
+To initially set up your machine if you are a local user, you'd do
+something like this:</para>
+  
+<example><title>Setting up the groups file for local accounts</title>
 <screen>
 <prompt>$</prompt> <userinput>mkdir /etc</userinput>
 <prompt>$</prompt> <userinput>mkgroup -l &gt; /etc/group</userinput>
@@ -408,16 +410,24 @@ information in your system, you'll need 
 for it to have the new information.</para>
 
 <para>The <literal>-d</literal> and <literal>-l</literal> options
-allow you to specify where the information comes from, either the
-local machine or the default (or given) domain.  The <literal>-o</literal>
-option allows for special cases (such as multiple domains) where the GIDs 
-might match otherwise. The <literal>-s</literal>
+allow you to specify where the information comes from, the
+local machine or the domain (default or given), or both.
+With the  <literal>-d</literal> option the program contacts the Domain
+Controller, which my be unreachable or have restricted access.
+An entry for the current domain user can then be created by using the
+option <literal>-c</literal> together with <literal>-l</literal>,
+but <literal>-c</literal> has no effect when used with <literal>-d</literal>.
+The <literal>-o</literal> option allows for special cases
+(such as multiple domains) where the GIDs might match otherwise.
+The <literal>-s</literal>
 option omits the NT Security Identifier (SID).  For more information on 
 SIDs, see <Xref Linkend="ntsec"> in the Cygwin User's Guide.  The
 <literal>-u</literal> option causes <command>mkgroup</command> to 
 enumerate the users for each group, placing the group members in the 
 gr_mem (last) field.  Note that this can greatly increase
 the time for <command>mkgroup</command> to run in a large domain.
+Having gr_mem fields is helpful when a domain user logs in remotely
+while the local machine is disconnected from the Domain Controller.
 </para>
 
 </sect2>
@@ -431,6 +441,7 @@ This program prints a /etc/passwd file t
 
 Options:
    -l,--local              print local user accounts
+   -c,--current            print current account, if a domain account
    -d,--domain             print domain accounts (from current domain
                            if no domain specified)
    -o,--id-offset offset   change the default offset (10000) added to uids
@@ -450,14 +461,17 @@ One of `-l', `-d' or `-g' must be given 
 
 <para>The <command>mkpasswd</command> program can be used to help
 configure your Windows system to be more UNIX-like by creating an
-initial <filename>/etc/passwd</filename> substitute (some commands
-need this file) from your system information. It only works on the NT series
-(Windows NT, 2000, and XP). <command>mkpasswd</command> does not work on 
-the Win9x series (Windows 95, 98, and Me) because they lack the security model 
-to support it. To initially set up your machine, you'd do something like 
-this:</para>
-
-<example><title>Setting up the passwd file</title>
+initial <filename>/etc/passwd</filename> from your system information.
+Its use is essential on the NT series (Windows NT, 2000, and XP) to
+include Windows security information, but the actual passwords are
+determined by Windows, not by the content of <filename>/etc/passwd</filename>.
+On the Win9x series (Windows 95, 98, and Me) the password field must be
+replaced by the output of <userinput>crypt your_password</userinput>
+if remote access is desired.
+To initially set up your machine if you are a local user, you'd do
+something like this:</para>
+  
+<example><title>Setting up the passwd file for local accounts</title>
 <screen>
 <prompt>$</prompt> <userinput>mkdir /etc</userinput>
 <prompt>$</prompt> <userinput>mkpasswd -l &gt; /etc/passwd</userinput>
@@ -469,10 +483,16 @@ information in your system, you'll need 
 for it to have the new information.</para>
 
 <para>The <literal>-d</literal> and <literal>-l</literal> options
-allow you to specify where the information comes from, either the
-local machine or the default (or given) domain.  The <literal>-o</literal>
-option allows for special cases (such as multiple domains) where the UIDs
-might match otherwise.  The <literal>-g</literal> option creates a local
+allow you to specify where the information comes from, the
+local machine or the domain (default or given), or both.
+With the  <literal>-d</literal> option the program contacts the Domain
+Controller, which my be unreachable or have restricted access.
+An entry for the current domain user can then be created by using the
+option <literal>-c</literal> together with <literal>-l</literal>,
+but <literal>-c</literal> has no effect when used with <literal>-d</literal>.
+The <literal>-o</literal> option allows for special cases
+(such as multiple domains) where the UIDs might match otherwise.
+The <literal>-g</literal> option creates a local
 user that corresponds to each local group. This is because NT assigns groups
 file ownership.  The <literal>-m</literal> option bypasses the current
 mount table so that, for example, two users who have a Windows home 
@@ -489,9 +509,9 @@ use a prefix other than <literal>/home/<
 </example>
 
 would put local users' home directories in the Windows 'Profiles' directory. 
-The <literal>-u</literal> option allows <command>mkpasswd</command> to 
-search for a specific username, greatly reducing the amount of time it 
-takes in a large domain.</para>
+On Win9x machines the <literal>-u</literal> option creates an entry for
+the specified user. On the NT series it restricts the output to that user,
+greatly reducing the amount of time it takes in a large domain.</para>
 
 </sect2>
 

--2fHTh5uZTiUOsy+g--
