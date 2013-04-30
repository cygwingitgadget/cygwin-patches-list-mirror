Return-Path: <cygwin-patches-return-7864-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15866 invoked by alias); 30 Apr 2013 00:52:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15853 invoked by uid 89); 30 Apr 2013 00:52:23 -0000
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=AWL,BAYES_50,KHOP_THREADED,RP_MATCHES_RCVD,TW_CG,TW_TJ autolearn=ham version=3.3.1
Received: from etr-usa.com (HELO etr-usa.com) (130.94.180.135)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Tue, 30 Apr 2013 00:52:09 +0000
Received: (qmail 68230 invoked by uid 13447); 30 Apr 2013 00:52:06 -0000
Received: from unknown (HELO [172.20.0.42]) ([107.4.26.51])          (envelope-sender <warren@etr-usa.com>)          by 130.94.180.135 (qmail-ldap-1.03) with SMTP          for <cygwin-patches@cygwin.com>; 30 Apr 2013 00:52:06 -0000
Message-ID: <517F15AF.5080307@etr-usa.com>
Date: Tue, 30 Apr 2013 00:52:00 -0000
From: Warren Young <warren@etr-usa.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: [PATCH] DocBook XML toolchain modernization
References: <20130423152014.GG26397@calimero.vinschen.de> <5178049C.7000108@etr-usa.com> <20130424172039.GA27256@calimero.vinschen.de> <51782505.5020502@etr-usa.com> <20130424185210.GE26397@calimero.vinschen.de> <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de>
In-Reply-To: <20130425084305.GA29270@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------020602000108030501060005"
X-SW-Source: 2013-q2/txt/msg00002.txt.bz2

This is a multi-part message in MIME format.
--------------020602000108030501060005
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 10261

In the "HELP with Cygwin docs needed" thread on -apps, I volunteered to 
bring the docs up to date with regard to current DocBook XML practices.

RATIONALE
~~~~~~~~~
1. The docs are almost entirely moved away from SGML already, but need 
this last push to get them mostly into a pure XML world.  (There is one 
thing remaining, covered in the DOCTOOL section below.)

2. The doctool wheel has been reinvented, and the new versions are now 
far more popular.  By sticking with this old tool, you are shutting off 
potential sources of help.  You'll find more people who will admit to 
knowing DocBook XML and XIncludes than SGML and doctool.

3. This change set provides a better platform to build on.  For example, 
it will allow *.xml to be automatically validated at build time.  (In 
C/C++ terms, we can now do -Wall -Werror, if we want.)

4. Why build an intermediary helper program which creates intermediary 
outputs we have to clean up after when we can get most of the benefit of 
doctool via xsltproc, which we were already using?


APOLOGY
~~~~~~~

The changes required were rather invasive, so I haven't simply attached 
a single monster .patch file.  (If I had, you'd barf, with good cause.) 
Instead, following are instructions for a committer to bring the current 
CVS tree into the shape I have my read-only checkout in now.

Before I get to that, yes, I am aware that monster "change the world" 
patches are frowned on.  I have tried to keep the scope of this change 
set to a minimum, purposely deferring ideas I had along the way if they 
didn't absolutely have to be done in this pass.  (See FUTURE WORK 
section below.)

There's no incremental way to do some of these things.  When you make 
the decision to switch to proper XML from a semi-XML SGML variant that 
doesn't validate, a lot of stuff has to change at once.  My apologies 
for the work this causes to the one who has to check all this in.


STEPS
~~~~~

1. Rename cygwin-api.in.sgml to cygwin-api.in.xml.  This is the lone 
file still being processed with doctool.  I propose to replace this 
holdout with Doxygen; see FURTHER WORK below.

2. Rename all remaining *.in.sgml to *.xml.  One of the attached patches 
converts these mostly-XML files into proper XML files and converts all 
doctool directives to XIncludes.

3. Remove faq-sections.xml.  See the DUAL FAQ FORMATS section below for 
an explanation.

4. Copy all attached *.xml into winsup/doc, then "cvs add *.xml".

All of the copied files will be new to the directory, except for faq.xml 
which purely replaces the previous one.  The changes were extensive 
enough to make sending it as a patch inefficient.

The ug-info.xml addition could have been put off for later, but what it 
does is fixes a problem where the two output formats for the Cygwin user 
guide had different <bookinfo> element contents, implying that their 
authorship differed.  This file provides a common version which both 
versions now XInclude.

The rest all contain a single DocBook element (e.g. <sect1>, <chapter>) 
extracted from another file which had two or more of these as top-level 
elements.  XML only allows a single top-level element, a fact the 
SGML-based doctool was glossing over for us.  Now that we're using a 
purely XML toolchain, we have to follow the rules.  Each new file is 
named after the ID of the top-level element it contains.

5. Remove overview2.sgml and setup2.sgml.  These existed purely to hold 
multiple DocBook XML fragments that each now live in their own 
individual files, which were added in the previous step.  (Not all of 
the XML files added in step 3 came from these two containers.)

6. Rename all remaining *.sgml to *.xml.  These files were already 
DocBook XML, not DocBook SGML, and apparently had been so for years 
despite the file name.  One of the attached patches adds the necessary 
<?xml> and <!DOCTYPE> tags to the top of each of these files.

7. Rename cygwin.dsl to cygwin.xsl.  As with the previous item, this 
file has for years contained XSL, not DSSSL.

8. Apply the attached patches:

- cygdoc-sgml-to-xml.patch: Gets rid of SGMLisms and outdated DocBook 
XML constructs, adds <?xml> and <!DOCTYPE> tags to the top of *.xml so 
they validate, and replaces doctool directives with XIncludes.

- cygdoc-build.patch: Updated doc build system for DocBook XML modernization

- cygdoc-changelog.patch: .

9. autoconf && ./configure && make

You should get the same outputs as before, except for...


DUAL FAQ FORMATS
~~~~~~~~~~~~~~~~

As far as I can tell, the two FAQ output formats are a legacy thing no 
longer needed on cygwin.com.  I recall that at one point the FAQ was on 
one HTML page per section, then at my request cgf changed it to a 
single-page form so it's more easily searched in a browser.

The changes required to create a faq.xml which works with XIncludes 
break the method used to get two different FAQ forms from a single set 
of FAQ section files.  I know how to get dual outputs back again if we 
really need them, but if I'm right and we don't need the second output 
form, I can avoid some pointless grunt work.

If I am right and we only need one of the two output forms, please check 
that I have selected the right one.  If I've gotten this backwards and 
we need the other instead but CVS can be broken for a short time without 
breaking anything else, it's probably best to check this in as-is, since 
a patch to fix the problem would be smaller than sending a new set of 
faq*.xml.  (I'm assuming a CVS check-in to the docs doesn't immediately 
show up on the public cygwin.com web site.)


DOCTOOL
~~~~~~~

doctool is a program written by DJ Delorie in the SGML days.  In 2001, 
W3C approved an XML standard called XInclude that does the main thing 
the Cygwin docs need, and it's supported by the current DocBook XML 
toolchain we're using.

There are two things doctool does that we don't get from XIncludes:

1. Automatic Makefile dependency generation.  I think we can live 
without it, but I propose to try and replace this feature anyway.

2. Documentation extraction from source code files.  I propose to 
replace this with Doxygen.  (Yes, I'm volunteering to do the conversion 
and set it up in the doc/Makefile.in.)


FURTHER WORK
~~~~~~~~~~~~

- Find/build XInclude-aware automatic Makefile dependency generator.  At 
worst, this shouldn't be much more than a bit of shell and sed.

- Convert existing SGML code embedded in Cygwin source code to Doxygen 
format, then set up HTML and PDF reference manual generation in 
doc/Makefile.in.  Then, remove vestiges of doctool.

- When doctool is removed, the only thing Autoconf will be left doing is 
defining the @srcdir@ stuff.  If this feature is being used, it is easy 
to replace Autoconf here: "SRCDIR=.. make".  If not, then Autoconf will 
be doing absolutely nothing any more.  Either way, remove it; it isn't 
pulling its own weight.

- Remove configure script from repo.  It's a generated file, and so 
doesn't belong in CVS.  This will either be part of the previous item, 
or if for some reason Autoconf still has a role to play, it should be 
replaced with a bootstrap script.

- There are absolute HTTP <ulinks> which should be transformed to 
relative links so that they do the right thing when you move the docs 
around.  Maybe they'll never live somewhere else on cygwin.com, but if 
nothing else, they currently do the wrong thing when you open one of the 
generated .html files from the local filesystem: hyperlinks take you off 
to cygwin.com instead of to the relevant local file.

- Move to DocBook 5.  The standard's been out for 3 and a half years 
now.  The only thing blocking me from attempting the upgrade right now 
is that the DocBook 5.x stylesheets aren't in the Cygwin package repo.

- Files are often named with less detail than the ID of the top-level 
XML element it contains.  For example, specialnames.xml contains <sect1 
id="using-specialnames">.  The ID scheme seems hierarchical, so maybe 
the files should go into subdirectories; e.g. using/specialnames.xml. 
This would help with the proliferation of files this "patch" created.

- The XML files should be run through a "tidy" tool.  XML is easier to 
read when properly indented, and DocBook XML is insensitive to such 
whitespace issues.

- Remove --skip-validation from XMLTO flags variable in Makefile.in, 
then fix any errors and warnings that result.

- Replace the hard-coded dates in <bookinfo><date> tags with DocBook 
time stamps.  (http://www.sagehill.net/docbookxsl/Datetime.html)

- cygwin-ug-net/cygwin-ug-net-nochunks.html.gz build rules can probably 
be reduced to a one-liner by moving from xmlto wrapper to a raw xsltproc 
call.

- Is xmlto pulling its own weight for the HTML case?  It *might* have 
some value for the PDF-via-dblatex case, but an xsltproc call for HTML 
is also a one-liner.

- Typography improvements: curl all the quotation marks, replace "--" 
with em dashes, check proper names for missing accents, etc.

- Put code snippets in CDATA sections so we can replace XHTML entities 
with their literal equivalents.  (e.g. all the "&lt;" and "&amp;" stuff 
becomes < and &.)

- Pretty code snippets.  Search for a DocBook aware automatic code 
formatter that will take raw example code in and mark it up, as exists 
for HTML.  If one can't be found or created -- e.g. by lashing an HTML 
code formatter to a sed script then whipping them until they sing -- do 
the markup by hand.

- Adapt top-level cygwin.com CSS to HTML, so the user guide blends with 
the rest of the site.  (Something like this has been done to 
cygwin.com/faq.html, perhaps by hand, perhaps automated in a one-off way 
I don't see here.)

- Improve PDF styling.

- Change the '-' prefixes on Makefile.in commands to '@'.  We only want 
to avoid echoing the commands, not keep on trucking past build errors.


MAINTAINERSHIP?
~~~~~~~~~~~~~~~

In the previous thread on -apps, Corinna implied that if I provided this 
change set, it would make me the new docs maintainer.  (Last one to 
touch it owns it?)  I don't see how this can be, since I don't have a 
CVS commit bit.

I did submit a copyright assignment to Red Hat many moons ago, so that 
should be no barrier to accepting this change set.

--------------020602000108030501060005
Content-Type: text/xml;
 name="setup-env.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setup-env.xml"
Content-length: 5007

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<sect1 id="setup-env"><title>Environment Variables</title>

<sect2 id="setup-env-ov"><title>Overview</title>

<para>
All Windows environment variables are imported when Cygwin starts.
Apart from that, you may wish to specify settings of several important
environment variables that affect Cygwin's operation.</para>

<para>
The <envar>CYGWIN</envar> variable is used to configure a few global
settings for the Cygwin runtime system.  Typically you can leave
<envar>CYGWIN</envar> unset, but if you want to set one ore more
options, you can set it using a syntax like this, depending on the shell
in which you're setting it.  Here is an example in CMD syntax:</para>

<screen>
<prompt>C:\&gt;</prompt> <userinput>set CYGWIN=error_start:C:\cygwin\bin\gdb.exe glob</userinput>
</screen>

<para>
This is, of course, just an example.  For the recognized settings of the
<envar>CYGWIN</envar> environment variable, see
<xref linkend="using-cygwinenv"></xref>.
</para>

<para>
Locale support is controlled by the <envar>LANG</envar> and
<envar>LC_xxx</envar> environment variables.  Since Cygwin 1.7.2, all of
them are honored and have a meaning.  For a more detailed description see
<xref linkend="setup-locale"></xref>.
</para>

<para>
The <envar>PATH</envar> environment variable is used by Cygwin
applications as a list of directories to search for executable files
to run.  This environment variable is converted from Windows format
(e.g. <filename>C:\Windows\system32;C:\Windows</filename>) to UNIX format
(e.g., <filename>/cygdrive/c/Windows/system32:/cygdrive/c/Windows</filename>)
when a Cygwin process first starts.
Set it so that it contains at least the <filename>x:\cygwin\bin</filename>
directory where "<filename>x:\cygwin</filename> is the "root" of your
cygwin installation if you wish to use cygwin tools outside of bash.
This is usually done by the batch file you're starting your shell with.
</para>

<para> 
The <envar>HOME</envar> environment variable is used by many programs to
determine the location of your home directory and we recommend that it be
defined.  This environment variable is also converted from Windows format
when a Cygwin process first starts.  It's usually set in the shell
profile scripts in the /etc directory.
</para>

<para>
The <envar>TERM</envar> environment variable specifies your terminal
type.  It is automatically set to <literal>cygwin</literal> if you have
not set it to something else.
</para>

<para>The <envar>LD_LIBRARY_PATH</envar> environment variable is used by
the Cygwin function <function>dlopen ()</function> as a list of
directories to search for .dll files to load.  This environment variable
is converted from Windows format to UNIX format when a Cygwin process
first starts.  Most Cygwin applications do not make use of the
<function>dlopen ()</function> call and do not need this variable.
</para>

<para>
In addition to <envar>PATH</envar>, <envar>HOME</envar>,
and <envar>LD_LIBRARY_PATH</envar>, there are three other environment
variables which, if they exist in the Windows environment, are
converted to UNIX format: <envar>TMPDIR</envar>, <envar>TMP</envar>,
and <envar>TEMP</envar>.  The first is not set by default in the
Windows environment but the other two are, and they point to the
default Windows temporary directory.  If set, these variables will be
used by some Cygwin applications, possibly with unexpected results.
You may therefore want to unset them by adding the following two lines
to your <filename>~/.bashrc</filename> file:

<screen>
unset TMP
unset TEMP
</screen>

This is done in the default <filename>~/.bashrc</filename> file.
Alternatively, you could set <envar>TMP</envar>
and <envar>TEMP</envar> to point to <filename>/tmp</filename> or to
any other temporary directory of your choice.  For example:

<screen>
export TMP=/tmp
export TEMP=/tmp
</screen>
</para>

</sect2>

<sect2 id="setup-env-win32"><title>Restricted Win32 environment</title>

<para>There is a restriction when calling Win32 API functions which
require a fully set up application environment.  Cygwin maintains its own
environment in POSIX style.  The Win32 environment is usually stripped
to a bare minimum and not at all kept in sync with the Cygwin POSIX
environment.</para>

<para>If you need the full Win32 environment set up in a Cygwin process,
you have to call</para>

<screen>
#include &lt;sys/cygwin.h&gt;

cygwin_internal (CW_SYNC_WINENV);
</screen>

<para>to synchronize the Win32 environment with the Cygwin environment.
Note that this only synchronizes the Win32 environment once with the
Cygwin environment.  Later changes using the <function>setenv</function>
or <function>putenv</function> calls are not reflected in the Win32
environment.  In these cases, you have to call the aforementioned
<function>cygwin_internal</function> call again.</para>

</sect2>

</sect1>

--------------020602000108030501060005
Content-Type: text/xml;
 name="setup-files.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setup-files.xml"
Content-length: 3469

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<sect1 id="setup-files"><title>Customizing bash</title>

<para>
To set up bash so that cut and paste work properly, click on the
"Properties" button of the window, then on the "Misc" tab.  Make sure
that "QuickEdit mode" and "Insert mode" are checked.  These settings
will be remembered next time you run bash from that shortcut. Similarly
you can set the working directory inside the "Program" tab. The entry
"%HOME%" is valid, but requires that you set <envar>HOME</envar> in
the Windows environment.
</para>

<para>
Your home directory should contain three initialization files
that control the behavior of bash.  They are
<filename>.profile</filename>, <filename>.bashrc</filename> and
<filename>.inputrc</filename>.  The Cygwin base installation creates
stub files when you start bash for the first time.</para>

<para>
<filename>.profile</filename> (other names are also valid, see the bash man
page) contains bash commands.  It is executed when bash is started as login
shell, e.g. from the command <command>bash --login</command>.
This is a useful place to define and
export environment variables and bash functions that will be used by bash
and the programs invoked by bash.  It is a good place to redefine
<envar>PATH</envar> if needed.  We recommend adding a ":." to the end of
<envar>PATH</envar> to also search the current working directory (contrary
to DOS, the local directory is not searched by default).  Also to avoid
delays you should either <command>unset</command> <envar>MAILCHECK</envar> 
or define <envar>MAILPATH</envar> to point to your existing mail inbox.
</para>

<para>
<filename>.bashrc</filename> is similar to
<filename>.profile</filename> but is executed each time an interactive
bash shell is launched.  It serves to define elements that are not
inherited through the environment, such as aliases. If you do not use
login shells, you may want to put the contents of
<filename>.profile</filename> as discussed above in this file
instead.
</para>

<para>
<screen>
shopt -s nocaseglob
</screen>
will allow bash to glob filenames in a case-insensitive manner.
Note that <filename>.bashrc</filename> is not called automatically for login 
shells. You can source it from <filename>.profile</filename>.
</para>

<para>
<filename>.inputrc</filename> controls how programs using the readline
library (including <command>bash</command>) behave.  It is loaded
automatically.  For full details see the <literal>Function and Variable
Index</literal> section of the GNU <systemitem>readline</systemitem> manual.
Consider the following settings:
<screen>
# Ignore case while completing
set completion-ignore-case on
# Make Bash 8bit clean
set meta-flag on
set convert-meta off
set output-meta on
</screen>
The first command makes filename completion case insensitive, which can
be convenient in a Windows environment.  The next three commands allow
<command>bash</command> to display 8-bit characters, useful for
languages with accented characters.  Note that tools that do not use
<systemitem>readline</systemitem> for display, such as
<command>less</command> and <command>ls</command>, require additional
settings, which could be put in your <filename>.bashrc</filename>:
<screen>
alias less='/bin/less -r'
alias ls='/bin/ls -F --color=tty --show-control-chars'
</screen>
</para>

</sect1>


--------------020602000108030501060005
Content-Type: text/xml;
 name="setup-locale.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setup-locale.xml"
Content-length: 18536

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<sect1 id="setup-locale"><title>Internationalization</title>

<sect2 id="setup-locale-ov"><title>Overview</title>

<para>
Internationalization support is controlled by the <envar>LANG</envar> and
<envar>LC_xxx</envar> environment variables.  You can set all of them
but Cygwin itself only honors the variables <envar>LC_ALL</envar>,
<envar>LC_CTYPE</envar>, and <envar>LANG</envar>, in this order, according
to the POSIX standard.  The content of these variables should follow the
POSIX standard for a locale specifier.  The correct form of a locale
specifier is</para>

<screen>
  language[[_TERRITORY][.charset][@modifier]]
</screen>

<para>"language" is a lowercase two character string per ISO 639-1, or,
if there is no ISO 639-1 code for the language (for instance, "Lower Sorbian"),
a three character string per ISO 639-3.</para>

<para>"TERRITORY" is an uppercase two character string per ISO 3166, charset is
one of a list of supported character sets.  The modifier doesn't matter
here (though some are recognized, see below).  If you're interested in the
exact description, you can find it in the online publication of the POSIX
manual pages on the homepage of the
<ulink url="http://www.opengroup.org/">Open Group</ulink>.</para>

<para>Typical locale specifiers are</para>

<screen>
  "de_CH"	   language = German, territory = Switzerland, default charset
  "fr_FR.UTF-8"    language = french, territory = France, charset = UTF-8
  "ko_KR.eucKR"    language = korean, territory = South Korea, charset = eucKR
  "syr_SY"         language = Syriac, territory = Syria, default charset
</screen>

<para>
If the locale specifier does not follow the above form, Cygwin checks
if the locale is one of the locale aliases defined in the file
<filename>/usr/share/locale/locale.alias</filename>.  If so, and if
the replacement localename is supported by the underlying Windows,
the locale is accepted, too.  So, given the default content of the
<filename>/usr/share/locale/locale.alias</filename> file, the below
examples would be valid locale specifiers as well.
</para>

<screen>
  "catalan"        defined as "ca_ES.ISO-8859-1" in locale.alias
  "japanese"       defined as "ja_JP.eucJP"      in locale.alias
  "turkish"        defined as "tr_TR.ISO-8859-9" in locale.alias
</screen>

<para>The file <filename>/usr/share/locale/locale.alias</filename> is
provided by the gettext package under Cygwin.</para>

<para>
At application startup, the application's locale is set to the default
"C" or "POSIX" locale.  Under Cygwin 1.7.2 and later, this locale defaults
to the ASCII character set on the application level.  If you want to stick
to the "C" locale and only change to another charset, you can define this
by setting one of the locale environment variables to "C.charset".  For
instance</para>

<screen>
  "C.ISO-8859-1"
</screen>

<note><para>The default locale in the absence of the aforementioned locale
environment variables is "C.UTF-8".</para></note>

<para>Windows uses the UTF-16 charset exclusively to store the names
of any object used by the Operating System.  This is especially important
with filenames.  Cygwin uses the setting of the locale environment variables
<envar>LC_ALL</envar>, <envar>LC_CTYPE</envar>, and <envar>LANG</envar>, to
determine how to convert Windows filenames from their UTF-16 representation
to the singlebyte or multibyte character set used by Cygwin.</para>

<para>
The setting of the locale environment variables at process startup
is effective for Cygwin's internal conversions to and from the Windows UTF-16
object names for the entire lifetime of the current process.  Changing
the environment variables to another value changes the way filenames are
converted in subsequently started child processes, but not within the same
process.</para>

<para>
However, even if one of the locale environment variables is set to
some other value than "C", this does <emphasis>only</emphasis> affect
how Cygwin itself converts filenames.  As the POSIX standard requires,
it's the application's responsibility to activate that locale for its
own purposes, typically by using the call</para>

<screen>
  setlocale (LC_ALL, "");
</screen>

<para>early in the application code.  Again, so that this doesn't get
lost:  If the application calls setlocale as above, and there is none
of the important locale variables set in the environment, the locale
is set to the default locale, which is "C.UTF-8".</para>

<para>But what about applications which are not locale-aware?  Per POSIX,
they are running in the "C" or "POSIX" locale, which implies the ASCII
charset.  The Cygwin DLL itself, however, will nevertheless use the locale
set in the environment (or the "C.UTF-8" default locale) for converting
filenames etc.</para>

<para>When the locale in the environment specifies an ASCII charset,
for example "C" or "en_US.ASCII", Cygwin will still use UTF-8
under the hood to translate filenames.  This allows for easier
interoperability with applications running in the default "C.UTF-8" locale.
</para>

<para>
Starting with Cygwin 1.7.2, the language and territory are used to
fetch locale-dependent information from Windows.  If the language and
territory are not known to Windows, the <function>setlocale</function>
function fails.</para>

<para>The following modifiers are recognized.  Any other modifier is simply
ignored for now.</para>

<itemizedlist mark="bullet">

<listitem><para>
For locales which use the Euro (EUR) as currency, the modifier "@euro"
can be added to enforce usage of the ISO-8859-15 character set, which
includes a character for the "Euro" currency sign.
</para></listitem>

<listitem><para>
The default script used for all Serbian language locales (sr_BA, sr_ME, sr_RS,
and the deprecated sr_CS and sr_SP) is cyrillic.  With the "@latin" modifier
it gets switched to the latin script with the respective collation behaviour.
</para></listitem>

<listitem><para>
The default charset of the "be_BY" locale (Belarusian/Belarus) is CP1251.
With the "@latin" modifier it's UTF-8.
</para></listitem>

<listitem><para>
The default charset of the "tt_RU" locale (Tatar/Russia) is ISO-8859-5.
With the "@iqtelif" modifier it's UTF-8.
</para></listitem>

<listitem><para>
The default charset of the "uz_UZ" locale (Uzbek/Uzbekistan) is ISO-8859-1.
With the "@cyrillic" modifier it's UTF-8.
</para></listitem>

<listitem><para>
There's a class of characters in the Unicode character set, called the
"CJK Ambiguous Width" characters.  For these characters, the width
returned by the wcwidth/wcswidth functions is usually 1.  This can be a
problem with East-Asian languages, which historically use character sets
where these characters have a width of 2.  Therefore, wcwidth/wcswidth
return 2 as the width of these characters when an East-Asian charset such
as GBK or SJIS is selected, or when UTF-8 is selected and the language is
specified as "zh" (Chinese), "ja" (Japanese), or "ko" (Korean).  This is
not correct in all circumstances, hence the locale modifier "@cjknarrow"
can be used to force wcwidth/wcswidth to return 1 for the ambiguous width
characters.
</para></listitem>

</itemizedlist>

</sect2>

<sect2 id="setup-locale-how"><title>How to set the locale</title>

<itemizedlist mark="bullet">

<listitem><para>
Assume that you've set one of the aforementioned environment variables to some
valid POSIX locale value, other than "C" and "POSIX".  Assume further that
you're living in Japan.  You might want to use the language code "ja" and the
territory "JP", thus setting, say, <envar>LANG</envar> to "ja_JP".  You didn't
set a character set, so what will Cygwin use now?  Starting with Cygwin 1.7.2,
the default character set is determined by the default Windows ANSI codepage
for this language and territory.  Cygwin uses a character set which is the
typical Unix-equivalent to the Windows ANSI codepage.  For instance:</para>

<screen>
  "en_US"		ISO-8859-1
  "el_GR"		ISO-8859-7
  "pl_PL"		ISO-8859-2
  "pl_PL@euro"		ISO-8859-15
  "ja_JP"		EUCJP
  "ko_KR"		EUCKR
  "te_IN"		UTF-8
</screen>
</listitem>

<listitem><para>
You don't want to use the default character set?  In that case you have to
specify the charset explicitly.  For instance, assume you're from Japan and
don't want to use the japanese default charset EUC-JP, but the Windows
default charset SJIS.  What you can do, for instance, is to set the
<envar>LANG</envar> variable in the <command>mintty</command> Cygwin Terminal
in the "Text" section of its "Options" dialog.  If you're starting your
Cygwin session via a batch file or a shortcut to a batch file, you can also
just set LANG there:</para>

<screen>
  @echo off

  C:
  chdir C:\cygwin\bin
  set LANG=ja_JP.SJIS
  bash --login -i
</screen>

<note><para>For a list of locales supported by your Windows machine, use the new
<command>locale -a</command> command, which is part of the Cygwin package.
For a description see <xref linkend="locale"></xref></para></note>

<note><para>For a list of supported character sets, see
<xref linkend="setup-locale-charsetlist"></xref>
</para></note>
</listitem>

<listitem><para>
Last, but not least, most singlebyte or doublebyte charsets have a big
disadvantage.  Windows filesystems use the Unicode character set in the
UTF-16 encoding to store filename information.  Not all characters
from the Unicode character set are available in a singlebyte or doublebyte
charset.  While Cygwin has a workaround to access files with unusual
characters (see <xref linkend="pathnames-unusual"></xref>), a better
workaround is to use always the UTF-8 character set.</para>

<para><emphasis>UTF-8 is the only multibyte character set which can represent
every Unicode character.</emphasis></para>

<screen>
  set LANG=es_MX.UTF-8
</screen>

<para>For a description of the Unicode standard, see the homepage of the
<ulink url="http://www.unicode.org/">Unicode Consortium</ulink>.
</para></listitem>

</itemizedlist>

</sect2>

<sect2 id="setup-locale-console"><title>The Windows Console character set</title>

<para>Sometimes the Windows console is used to run Cygwin applications.
While terminal emulations like the Cygwin Terminal <command>mintty</command>
or <command>xterm</command> have a distinct way to set the character set
used for in- and output, the Windows console hasn't such a way, since it's
not an application in its own right.</para>

<para>This problem is solved in Cygwin as follows.  When a Cygwin
process is started in a Windows console (either explicitly from cmd.exe,
or implicitly by, for instance, running the
<filename>C:\cygwin\Cygwin.bat</filename> batch file), the Console character
set is determined by the setting of the aforementioned
internationalization environment variables, the same way as described in
<xref linkend="setup-locale-how"></xref>.  </para>

<para>What is that good for?  Why not switch the console character set with
the applications requirements?  After all, the application knows if it uses
localization or not.  However, what if a non-localized application calls
a remote application which itself is localized?  This can happen with
<command>ssh</command> or <command>rlogin</command>.  Both commands don't
have and don't need localization and they never call
<function>setlocale</function>.  Setting one of the internationalization
environment variable to the same charset as the remote machine before
starting <command>ssh</command> or <command>rlogin</command> fixes that
problem.</para>

</sect2>

<sect2 id="setup-locale-problems"><title>Potential Problems when using Locales</title>

<para>
You can set the above internationalization variables not only when
starting the first Cygwin process, but also in your Cygwin shell on the
fly, even switch to yet another character set, and yet another.  In bash
for instance:</para>

<screen>
  <prompt>bash$</prompt> export LC_CTYPE="nl_BE.UTF-8"
</screen>

<para>However, here's a problem.  At the start of the first Cygwin process
in a session, the Windows environment is converted from UTF-16 to UTF-8.
The environment is another of the system objects stored in UTF-16 in
Windows.</para>

<para>As long as the environment only contains ASCII characters, this is
no problem at all.  But if it contains native characters, and you're planning
to use, say, GBK, the environment will result in invalid characters in
the GBK charset.  This would be especially a problem in variables like
<envar>PATH</envar>.  To circumvent the worst problems, Cygwin converts
the <envar>PATH</envar> environment variable to the charset set in the
environment, if it's different from the UTF-8 charset.</para>

<note><para>Per POSIX, the name of an environment variable should only
consist of valid ASCII characters, and only of uppercase letters, digits, and
the underscore for maximum portability.</para></note>

<para>Symbolic links, too, may pose a problem when switching charsets on
the fly.  A symbolic link contains the filename of the target file the
symlink points to.  When a symlink had been created with older versions
of Cygwin, the current ANSI or OEM character set had been used to store
the target filename, dependent on the old <envar>CYGWIN</envar>
environment variable setting <envar>codepage</envar> (see <xref
linkend="cygwinenv-removed-options"></xref>.  If the target filename
contains non-ASCII characters and you use another character set than
your default ANSI/OEM charset, the target filename of the symlink is now
potentially an invalid character sequence in the new character set.
This behaviour is not different from the behaviour in other Operating
Systems.  So, if you suddenly can't access a symlink anymore which
worked all these years before, maybe it's because you switched to
another character set.  This doesn't occur with symlinks created with
Cygwin 1.7 or later.  </para>

<para>Another problem you might encounter is that older versions of
Windows did not install all charsets by default.  If you are running
Windows XP or older, you can open the "Regional and Language Options"
portion of the Control Panel, select the "Advanced" tab, and select
entries from the "Code page conversion tables" list.  The following
entries are useful to cygwin: 932/SJIS, 936/GBK, 949/EUC-KR, 950/Big5,
20932/EUC-JP.</para>

</sect2>

<sect2 id="setup-locale-charsetlist"><title>List of supported character sets</title>

<para>Last but not least, here's the list of currently supported character
sets.  The left-hand expression is the name of the charset, as you would use
it in the internationalization environment variables as outlined above.
Note that charset specifiers are case-insensitive.  <literal>EUCJP</literal>
is equivalent to <literal>eucJP</literal> or <literal>eUcJp</literal>.
Writing the charset in the exact case as given in the list below is a
good convention, though.
</para>

<para>The right-hand side is the number of the equivalent Windows
codepage as well as the Windows name of the codepage.  They are only
noted here for reference.  Don't try to use the bare codepage number or
the Windows name of the codepage as charset in locale specifiers, unless
they happen to be identical with the left-hand side.  Especially in case
of the "CPxxx" style charsets, always use them with the trailing "CP".</para>

<para>This works:</para>

<screen>
  set LC_ALL=en_US.CP437
</screen>

<para>This does <emphasis>not</emphasis> work:</para>

<screen>
  set LC_ALL=en_US.437
</screen>

<para>You can find a full list of Windows codepages on the Microsoft MSDN page
<ulink url="http://msdn.microsoft.com/en-us/library/dd317756(VS.85).aspx">Code Page Identifiers</ulink>.</para>

<screen>
    Charset               Codepage
    -------------------   -------------------------------------------
    ASCII                 20127 (US_ASCII)

    CP437                   437 (OEM United States)
    CP720                   720 (DOS Arabic)
    CP737                   737 (OEM Greek)
    CP775                   775 (OEM Baltic)
    CP850                   850 (OEM Latin 1, Western European)
    CP852                   852 (OEM Latin 2, Central European)
    CP855                   855 (OEM Cyrillic)
    CP857                   857 (OEM Turkish)
    CP858                   858 (OEM Latin 1 + Euro Symbol)
    CP862                   862 (OEM Hebrew)
    CP866                   866 (OEM Russian)
    CP874                   874 (ANSI/OEM Thai)
    CP932		    932 (Shift_JIS, not exactly identical to SJIS)
    CP1125                 1125 (OEM Ukraine)
    CP1250                 1250 (ANSI Central European)
    CP1251                 1251 (ANSI Cyrillic)
    CP1252                 1252 (ANSI Latin 1, Western European)
    CP1253                 1253 (ANSI Greek)
    CP1254                 1254 (ANSI Turkish)
    CP1255                 1255 (ANSI Hebrew)
    CP1256                 1256 (ANSI Arabic)
    CP1257                 1257 (ANSI Baltic)
    CP1258                 1258 (ANSI/OEM Vietnamese)

    ISO-8859-1            28591 (ISO-8859-1)
    ISO-8859-2            28592 (ISO-8859-2)
    ISO-8859-3            28593 (ISO-8859-3)
    ISO-8859-4            28594 (ISO-8859-4)
    ISO-8859-5            28595 (ISO-8859-5)
    ISO-8859-6            28596 (ISO-8859-6)
    ISO-8859-7            28597 (ISO-8859-7)
    ISO-8859-8            28598 (ISO-8859-8)
    ISO-8859-9            28599 (ISO-8859-9)
    ISO-8859-10             -   (not available)
    ISO-8859-11             -   (not available)
    ISO-8859-13           28603 (ISO-8859-13)
    ISO-8859-14             -   (not available)
    ISO-8859-15           28605 (ISO-8859-15)
    ISO-8859-16             -   (not available)

    Big5                    950 (ANSI/OEM Traditional Chinese)
    EUCCN or euc-CN         936 (ANSI/OEM Simplified Chinese)
    EUCJP or euc-JP       20932 (EUC Japanese)
    EUCKR or euc-KR         949 (EUC Korean)
    GB2312                  936 (ANSI/OEM Simplified Chinese)
    GBK                     936 (ANSI/OEM Simplified Chinese)
    GEORGIAN-PS             -   (not available)
    KOI8-R                20866 (KOI8-R Russian Cyrillic)
    KOI8-U                21866 (KOI8-U Ukrainian Cyrillic)
    PT154                   -   (not available)
    SJIS                    -   (not available, almost, but not exactly CP932)
    TIS620 or TIS-620       874 (ANSI/OEM Thai)

    UTF-8 or utf8         65001 (UTF-8)
</screen>

</sect2>

</sect1>

--------------020602000108030501060005
Content-Type: text/xml;
 name="setup-maxmem.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setup-maxmem.xml"
Content-length: 2971

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<sect1 id="setup-maxmem"><title>Changing Cygwin's Maximum Memory</title>

<para>
Cygwin's heap is extensible.  However, it does start out at a fixed size
and attempts to extend it may run into memory which has been previously
allocated by Windows.  In some cases, this problem can be solved by
changing a field in the file header which is utilized by Cygwin since
version 1.7.10 to keep the initial size of the application heap.  If the
field contains 0, which is the default, the application heap defaults to
a size of 384 Megabyte.  If the field is set to any other value between 4 and
2048, Cygwin tries to reserve as much Megabytes for the application heap.
The field used for this is the "LoaderFlags" field in the NT-specific
PE header structure (<literal>(IMAGE_NT_HEADER)->OptionalHeader.LoaderFlags</literal>).</para>

<para>
This value can be changed for any executable by using a more recent version
of the <command>peflags</command> tool from the <literal>rebase</literal>
Cygwin package.  Example:

<screen>
$ peflags --cygwin-heap foo.exe
foo.exe: initial Cygwin heap size: 0 (0x0) MB
$ peflags --cygwin-heap=500 foo.exe
foo.exe: initial Cygwin heap size: 500 (0x1f4) MB
</screen>
</para>

<para>
Heap memory can be allocated up to the size of the biggest available free
block in the processes virtual memory (VM).  By default, the VM per process
is 2 GB for 32 processes.  To get more VM for a process, the executable
must have the "large address aware" flag set in the file header.  You can
use the aforementioned <command>peflags</command> tool to set this flag.
On 64 bit systems this results in a 4 GB VM for a process started from that
executable.  On 32 bit systems you also have to prepare the system to allow
up to 3 GB per process.  See the Microsoft article
<ulink url="http://msdn.microsoft.com/en-us/library/bb613473%28VS.85%29.aspx">4-Gigabyte Tuning</ulink>
for more information.
</para>

<note>
<para>
Older Cygwin releases only supported a global registry setting to
change the initial heap size for all Cygwin processes.  This setting is
not used anymore.  However, if you're running an older Cygwin release
than 1.7.10, you can add the <literal>DWORD</literal> value
<literal>heap_chunk_in_mb</literal> and set it to the desired memory limit
in decimal MB.  You have to stop all Cygwin processes for this setting to
have any effect.  It is preferred to do this in Cygwin using the
<command>regtool</command> program included in the Cygwin package.
(see <xref linkend="regtool"></xref>) This example sets the memory limit
to 1024 MB for all Cygwin processes (use HKCU instead of HKLM if you
want to set this only for the current user):

<screen>
$ regtool -i set /HKLM/Software/Cygwin/heap_chunk_in_mb 1024
$ regtool -v list /HKLM/Software/Cygwin
</screen>
</para>
</note>

</sect1>

--------------020602000108030501060005
Content-Type: text/xml;
 name="specialnames.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="specialnames.xml"
Content-length: 22097

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<sect1 id="using-specialnames"><title>Special filenames</title>

<sect2 id="pathnames-etc"><title>Special files in /etc</title>

<para>Certain files in Cygwin's <filename>/etc</filename> directory are
read by Cygwin before the mount table has been established.  The list
of files is</para>

<screen>
  /etc/fstab
  /etc/fstab.d/$USER
  /etc/passwd
  /etc/group
</screen>

<para>These file are read using native Windows NT functions which have
no notion of Cygwin symlinks or POSIX paths.  For that reason
there are a few requirements as far as <filename>/etc</filename> is
concerned.</para>

<para>To access these files, the Cygwin DLL evaluates it's own full
Windows path, strips off the innermost directory component and adds
"\etc".  Let's assume the Cygwin DLL is installed as
<filename>C:\cygwin\bin\cygwin1.dll</filename>.  First the DLL name as
well as the innermost directory (<filename>bin</filename>) is stripped
off: <filename>C:\cygwin\</filename>.  Then "etc" and the filename to
look for is attached: <filename>C:\cygwin\etc\fstab</filename>.  So the
/etc directory must be parallel to the directory in which the cygwin1.dll
exists and <filename>/etc</filename> must not be a Cygwin symlink
pointing to another directory.  Consequentially none of the files from
the above list, including the directory <filename>/etc/fstab.d</filename>
is allowed to be a Cygwin symlink either.</para>

<para>However, native NTFS symlinks and reparse points are transparent
when accessing the above files so all these files as well as
<filename>/etc</filename> itself may be NTFS symlinks or reparse
points.</para>

<para>Last but not least, make sure that these files are world-readable.
Every process of any user account has to read these files potentially,
so world-readability is essential.  The only exception are the user
specific files <filename>/etc/fstab.d/$USER</filename>, which only have
to be readable by the $USER user account itself.</para>

</sect2>

<sect2 id="pathnames-dosdevices"><title>Invalid filenames</title>

<para>Filenames invalid under Win32 are not necessarily invalid
under Cygwin since release 1.7.0.  There are a few rules which
apply to Windows filenames.  Most notably, DOS device names like
<filename>AUX</filename>, <filename>COM1</filename>,
<filename>LPT1</filename> or <filename>PRN</filename> (to name a few)
cannot be used as filename or extension in a native Win32 application.
So filenames like <filename>prn.txt</filename> or <filename>foo.aux</filename>
are invalid filenames for native Win32 applications.</para>

<para>This restriction doesn't apply to Cygwin applications.  Cygwin
can create and access files with such names just fine.  Just don't try
to use these files with native Win32 applications.</para>

</sect2>

<sect2 id="pathnames-specialchars">
<title>Forbidden characters in filenames</title>

<para>Some characters are disallowed in filenames on Windows filesystems.
These forbidden characters are the ASCII control characters from ASCII
value 1 to 31, plus the following characters which have a special meaning
in the Win32 API:</para>

<screen>
  "   *   :   &lt;   &gt;   ?   |   \
</screen>

<para>Cygwin can't fix this, but it has a method to workaround this
restriction.  All of the above characters, except for the backslash,
are converted to special UNICODE characters in the range 0xf000 to 0xf0ff
(the "Private use area") when creating or accessing files.</para>

<para>The backslash has to be exempt from this conversion, because Cygwin
accepts Win32 filenames including backslashes as path separators on input. 
Converting backslashes using the above method would make this impossible.</para>

<para>Additionally Win32 filenames can't contain trailing dots and spaces
for DOS backward compatibility.  When trying to create files with trailing
dots or spaces, all of them are removed before the file is created.  This
restriction only affects native Win32 applications.  Cygwin applications
can create and access files with trailing dots and spaces without problems.
</para>

<para>An exception from this rule are some network filesystems (NetApp,
NWFS) which choke on these filenames.  They return with an error like
"No such file or directory" when trying to create such files.  Starting
with Cygwin 1.7.6, Cygwin recognizes these filesystems and works around
this problem by applying the same rule as for the other forbidden characters. 
Leading spaces and trailing dots and spaces will be converted to UNICODE
characters in the private use area.  This behaviour can be switched on
explicitely for a filesystem or a directory tree by using the mount option
<literal>dos</literal>.</para>

</sect2>

<sect2 id="pathnames-unusual">
<title>Filenames with unusual (foreign) characters</title>

<para> Windows filesystems use Unicode encoded as UTF-16
to store filename information.  If you don't use the UTF-8
character set (see <xref linkend="setup-locale"></xref>) then there's a
chance that a filename is using one or more characters which have no
representation in the character set you're using.</para>

<note><para>In the default "C" locale, Cygwin creates filenames using
the UTF-8 charset.  This will always result in some valid filename by
default, but again might impose problems when switching to a non-"C"
or non-"UTF-8" charset.</para></note>

<note><para>To avoid this scenario altogether, always use UTF-8 as the
character set.</para></note>

<para>If you don't want or can't use UTF-8 as character set for whatever
reason, you will nevertheless be able to access the file.  How does that
work?  When Cygwin converts the filename from UTF-16 to your character
set, it recognizes characters which can't be converted.  If that occurs,
Cygwin replaces the non-convertible character with a special character
sequence.  The sequence starts with an ASCII CAN character (hex code
0x18, equivalent Control-X), followed by the UTF-8 representation of the
character.  The result is a filename containing some ugly looking
characters.  While it doesn't <emphasis role='bold'>look</emphasis> nice, it
<emphasis role='bold'>is</emphasis> nice, because Cygwin knows how to convert
this filename back to UTF-16.  The filename will be converted using your
usual character set.  However, when Cygwin recognizes an ASCII CAN
character, it skips over the ASCII CAN and handles the following bytes as
a UTF-8 character.  Thus, the filename is symmetrically converted back to
UTF-16 and you can access the file.</para>

<note><para>Please be aware that this method is not entirely foolproof.
In some character set combinations it might not work for certain native
characters.</para>

<para>Only by using the UTF-8 charset you can avoid this problem safely.
</para></note>

</sect2>

<sect2 id="pathnames-casesensitive">
<title>Case sensitive filenames</title>

<para>In the Win32 subsystem filenames are only case-preserved, but not
case-sensitive.  You can't access two files in the same directory which
only differ by case, like <filename>Abc</filename> and
<filename>aBc</filename>.  While NTFS (and some remote filesystems)
support case-sensitivity, the NT kernel starting with Windows XP does
not support it by default.  Rather, you have to tweak a registry setting
and reboot.  For that reason, case-sensitivity can not be supported by Cygwin,
unless you change that registry value.</para>

<para>If you really want case-sensitivity in Cygwin, you can switch it
on by setting the registry value</para>

<screen>
HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel\obcaseinsensitive
</screen>

<para>to 0 and reboot the machine.</para>

<note>
<para>
When installing Microsoft's Services For Unix (SFU), you're asked if
you want to use case-sensitive filenames.  If you answer "yes" at this point,
the installer will change the aforementioned registry value to 0, too.  So, if
you have SFU installed, there's some chance that the registry value is already
set to case sensitivity.
</para>
</note>

<para>After you set this registry value to 0, Cygwin will be case-sensitive
by default on NTFS and NFS filesystems.  However, there are limitations: 
while two <emphasis role='bold'>programs</emphasis> <filename>Abc.exe</filename>
and <filename>aBc.exe</filename> can be created and accessed like other files,
starting applications is still case-insensitive due to Windows limitations
and so the program you try to launch may not be the one actually started.  Also,
be aware that using two filenames which only differ by case might
result in some weird interoperability issues with native Win32 applications.  
You're using case-sensitivity at your own risk.  You have been warned! </para>

<para>Even if you use case-sensitivity, it might be feasible to switch to
case-insensitivity for certain paths for better interoperability with
native Win32 applications (even if it's just Windows Explorer).  You can do
this on a per-mount point base, by using the "posix=0" mount option in
<filename>/etc/fstab</filename>, or your <filename>/etc/fstab.d/$USER</filename>
file.</para>

<para><filename>/cygdrive</filename> paths are case-insensitive by default.
The reason is that the native Windows %PATH% environment variable is not
always using the correct case for all paths in it.  As a result, if you use
case-sensitivity on the <filename>/cygdrive</filename> prefix, your shell
might claim that it can't find Windows commands like <command>attrib</command>
or <command>net</command>.  To ease the pain, the <filename>/cygdrive</filename>
path is case-insensitive by default and you have to use the "posix=1" setting
explicitly in <filename>/etc/fstab</filename> or
<filename>/etc/fstab.d/$USER</filename> to switch it to case-sensitivity,
or you have to make sure that the native Win32 %PATH% environment variable
is using the correct case for all paths throughout.</para>

<para>Note that mount points as well as device names and virtual
paths like /proc are always case-sensitive!  The only exception are
the subdirectories and filenames under /proc/registry, /proc/registry32
and /proc/registry64.  Registry access is always case-insensitive.
Read on for more information.</para>

</sect2>

<sect2 id="pathnames-posixdevices"> <title>POSIX devices</title>
<para>While there is no need to create a POSIX <filename>/dev</filename> 
directory, the directory is automatically created as part of a Cygwin
installation.  It's existence is often a prerequisit to run certain
applications which create symbolic links, fifos, or UNIX sockets in
<filename>/dev</filename>.  Also, the directories <filename>/dev/shm</filename>
and <filename>/dev/mqueue</filename> are required to exist to use named POSIX
semaphores, shared memory, and message queues, so a system without a real
<filename>/dev</filename> directory is functionally crippled.
</para>

<para>Apart from that, Cygwin automatically simulates POSIX devices
internally.  Up to Cygwin 1.7.11, these devices couldn't be seen with the
command <command>ls /dev/</command> although commands such as
<command>ls /dev/tty</command> worked fine.  Starting with Cygwin 1.7.12,
the <filename>/dev</filename> directory is automagically populated with
existing POSIX devices by Cygwin in a way comparable with a
<ulink url="http://en.wikipedia.org/wiki/Udev">udev</ulink> based virtual
<filename>/dev</filename> directory under Linux.</para>

<para>
Cygwin supports the following character devices commonly found on POSIX systems:
</para>

<screen>
/dev/null
/dev/zero
/dev/full

/dev/console	Pseudo device name for the current console window of a session.
		Up to Cygwin 1.7.9, this was the only name for a console.
		Different consoles were indistinguishable.
		Cygwin's /dev/console is not quite comparable with the console
		device on UNIX machines.

/dev/cons0      Starting with Cygwin 1.7.10, Console sessions are numbered from 
/dev/cons1	/dev/cons0 upwards.  Console device names are pseudo device
...		names, only accessible from processes within this very console
		session.  This is due to a restriction in Windows.

/dev/tty	The current controlling tty of a session.

/dev/ptmx	Pseudo tty master device.

/dev/pty0	Pseudo ttys are numbered from /dev/pty0 upwards as they are
/dev/pty1	requested.
...

/dev/ttyS0	Serial communication devices.  ttyS0 == Win32 COM1,
/dev/ttyS1	ttyS1 == COM2, etc.
...

/dev/pipe
/dev/fifo

/dev/mem	The physical memory of the machine.  Note that access to the
/dev/port	physical memory has been restricted with Windows Server 2003.
/dev/kmem	Since this OS, you can't access physical memory from user space.

/dev/kmsg	Kernel message pipe, for usage with sys logger services.

/dev/random	Random number generator.
/dev/urandom

/dev/dsp	Default sound device of the system.
</screen>

<para>
Cygwin also has several Windows-specific devices:
</para>

<screen>
/dev/com1	The serial ports, starting with COM1 which is the same as ttyS0.
/dev/com2	Please use /dev/ttySx instead.
...

/dev/conin	Same as Windows CONIN$.
/dev/conout	Same as Windows CONOUT$.
/dev/clipboard	The Windows clipboard, text only
/dev/windows	The Windows message queue.
</screen>

<para>
Block devices are accessible by Cygwin processes using fixed POSIX device
names.  These POSIX device names are generated using a direct conversion
from the POSIX namespace to the internal NT namespace.
E.g. the first harddisk is the NT internal device \device\harddisk0\partition0
or the first partition on the third harddisk is \device\harddisk2\partition1.
The first floppy in the system is \device\floppy0, the first CD-ROM is
\device\cdrom0 and the first tape drive is \device\tape0.</para>

<para>The mapping from physical device to the name of the device in the
internal NT namespace can be found in various places.  For hard disks and
CD/DVD drives, the Windows "Disk Management" utility (part of the
"Computer Management" console) shows that the mapping of "Disk 0" is
\device\harddisk0.  "CD-ROM 2" is \device\cdrom2.  Another place to find
this mapping is the "Device Management" console.  Disks have a
"Location" number, tapes have a "Tape Symbolic Name", etc.
Unfortunately, the places where this information is found is not very
well-defined.</para>

<para>
For external disks (USB-drives, CF-cards in a cardreader, etc) you can use
Cygwin to show the mapping.  <filename>/proc/partitions</filename>
contains a list of raw drives known to Cygwin.  The <command>df</command>
command shows a list of drives and their respective sizes.  If you match
the information between <filename>/proc/partitions</filename> and the
<command>df</command> output, you should be able to figure out which
external drive corresponds to which raw disk device name.</para>

<note><para>Apart from tape devices which are not block devices and are
by default accessed directly, accessing mass storage devices raw
is something you should only do if you know what you're doing and know how to
handle the information.  <emphasis role='bold'>Writing</emphasis> to a raw
mass storage device you should only do if you
<emphasis role='bold'>really</emphasis> know what you're doing and are aware
of the fact that any mistake can destroy important information, for the
device, and for you.  So, please, handle this ability with care.
<emphasis role='bold'>You have been warned.</emphasis></para></note>

<para>
Last but not least, the mapping from POSIX /dev namespace to internal
NT namespace is as follows:
</para>

<screen>
POSIX device name     Internal NT device name

/dev/st0	      \device\tape0, rewind
/dev/nst0	      \device\tape0, no-rewind
/dev/st1	      \device\tape1
/dev/nst1	      \device\tape1
...
/dev/st15
/dev/nst15

/dev/fd0	      \device\floppy0
/dev/fd1	      \device\floppy1
...
/dev/fd15

/dev/sr0	      \device\cdrom0
/dev/sr1	      \device\cdrom1
...
/dev/sr15

/dev/scd0	      \device\cdrom0
/dev/scd1	      \device\cdrom1
...
/dev/scd15

/dev/sda	      \device\harddisk0\partition0	(whole disk)
/dev/sda1	      \device\harddisk0\partition1	(first partition)
...
/dev/sda15	      \device\harddisk0\partition15	(fifteenth partition)

/dev/sdb	      \device\harddisk1\partition0
/dev/sdb1	      \device\harddisk1\partition1

[up to]

/dev/sddx	      \device\harddisk127\partition0
/dev/sddx1	      \device\harddisk127\partition1
...
/dev/sddx15	      \device\harddisk127\partition15
</screen>

<para>
if you don't like these device names, feel free to create symbolic
links as they are created on Linux systems for convenience:
</para>

<screen>
ln -s /dev/sr0 /dev/cdrom
ln -s /dev/nst0 /dev/tape
...
</screen>

</sect2>

<sect2 id="pathnames-exe"><title>The .exe extension</title>

<para>Win32 executable filenames end with <filename>.exe</filename>
but the <filename>.exe</filename> need not be included in the command,
so that traditional UNIX names can be used.  However, for programs that
end in <filename>.bat</filename> and <filename>.com</filename>, you
cannot omit the extension.  </para>

<para>As a side effect, the <command> ls filename</command> gives
information about <filename>filename.exe</filename> if
<filename>filename.exe</filename> exists and <filename>filename</filename>
does not.  In the same situation the function call
<function>stat("filename",..)</function> gives information about
<filename>filename.exe</filename>.  The two files can be distinguished
by examining their inodes, as demonstrated below.
<screen>
<prompt>bash$</prompt> <userinput>ls * </userinput>
a      a.exe     b.exe
<prompt>bash$</prompt> <userinput>ls -i a a.exe</userinput>
445885548 a       435996602 a.exe
<prompt>bash$</prompt> <userinput>ls -i b b.exe</userinput>
432961010 b       432961010 b.exe
</screen>
If a shell script <filename>myprog</filename> and a program
<filename>myprog.exe</filename> coexist in a directory, the shell
script has precedence and is selected for execution of
<command>myprog</command>.  Note that this was quite the reverse up to
Cygwin 1.5.19.  It has been changed for consistency with the rest of Cygwin.
</para>

<para>The <command>gcc</command> compiler produces an executable named
<filename>filename.exe</filename> when asked to produce
<filename>filename</filename>. This allows many makefiles written
for UNIX systems to work well under Cygwin.</para>

</sect2>

<sect2 id="pathnames-proc"><title>The /proc filesystem</title> 
<para>
Cygwin, like Linux and other similar operating systems, supports the
<filename>/proc</filename> virtual filesystem. The files in this
directory are representations of various aspects of your system,
for example the command <userinput>cat /proc/cpuinfo</userinput> 
displays information such as what model and speed processor you have.
</para>
<para>
One unique aspect of the Cygwin <filename>/proc</filename> filesystem
is <filename>/proc/registry</filename>, see next section.
</para>
<para>
The Cygwin <filename>/proc</filename> is not as complete as the
one in Linux, but it provides significant capabilities. The
<systemitem>procps</systemitem> package contains several utilities
that use it.
</para>
</sect2>

<sect2 id="pathnames-proc-registry"><title>The /proc/registry filesystem</title>
<para>
The <filename>/proc/registry</filename> filesystem provides read-only
access to the Windows registry.  It displays each <literal>KEY</literal>
as a directory and each <literal>VALUE</literal> as a file.  As anytime
you deal with the Windows registry, use caution since changes may result
in an unstable or broken system.  There are additionally subdirectories called
<filename>/proc/registry32</filename> and <filename>/proc/registry64</filename>.
They are identical to <filename>/proc/registry</filename> on 32 bit
host OSes.  On 64 bit host OSes, <filename>/proc/registry32</filename>
opens the 32 bit processes view on the registry, while
<filename>/proc/registry64</filename> opens the 64 bit processes view.
</para>
<para>
Reserved characters ('/', '\', ':', and '%') or reserved names
(<filename>.</filename> and <filename>..</filename>) are converted by
percent-encoding:
<screen>
<prompt>bash$</prompt> <userinput>regtool list -v '\HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices'</userinput>
...
\DosDevices\C: (REG_BINARY) = cf a8 97 e8 00 08 fe f7
...
<prompt>bash$</prompt> <userinput>cd /proc/registry/HKEY_LOCAL_MACHINE/SYSTEM</userinput>
<prompt>bash$</prompt> <userinput>ls -l MountedDevices</userinput>
...
-r--r----- 1 Admin SYSTEM  12 Dec 10 11:20 %5CDosDevices%5CC%3A
...
<prompt>bash$</prompt> <userinput>od -t x1 MountedDevices/%5CDosDevices%5CC%3A</userinput>
0000000 cf a8 97 e8 00 08 fe f7 01 00 00 00
</screen>
The unnamed (default) value of a key can be accessed using the filename
<filename>@</filename>.
</para>
<para>
If a registry key contains a subkey and a value with the same name
<filename>foo</filename>, Cygwin displays the subkey as
<filename>foo</filename> and the value as <filename>foo%val</filename>.
</para>
</sect2>

<sect2 id="pathnames-at"><title>The @pathnames</title> 
<para>To circumvent the limitations on shell line length in the native
Windows command shells, Cygwin programs, when invoked by non-Cygwin processes, expand their arguments
starting with "@" in a special way.  If a file
<filename>pathname</filename> exists, the argument
<filename>@pathname</filename> expands recursively to the content of
<filename>pathname</filename>. Double quotes can be used inside the
file to delimit strings containing blank space. 
In the following example compare the behaviors
<command>/bin/echo</command> when run from bash and from the Windows command prompt.</para>

<example id="pathnames-at-ex"><title> Using @pathname</title>
<screen>
<prompt>bash$</prompt> <userinput>/bin/echo  'This   is   "a     long"  line' > mylist</userinput>
<prompt>bash$</prompt> <userinput>/bin/echo @mylist</userinput>
@mylist
<prompt>bash$</prompt> <userinput>cmd</userinput>
<prompt>c:\&gt;</prompt> <userinput>c:\cygwin\bin\echo @mylist</userinput>
This is a     long line
</screen>
</example>
</sect2> 
</sect1>

--------------020602000108030501060005
Content-Type: text/xml;
 name="ug-info.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ug-info.xml"
Content-length: 871

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<bookinfo xmlns:xi="http://www.w3.org/2001/XInclude">
	<date>2001-22-03</date>
	<title>Cygwin User's Guide</title>
	<authorgroup>
		<author>
			<firstname>Joshua Daniel</firstname>
			<surname>Franklin</surname>
		</author>
		<author>
			<firstname>Corinna</firstname>
			<surname>Vinschen</surname>
		</author>
		<author>
			<firstname>Christopher</firstname>
			<surname>Faylor</surname>
		</author>
		<author>
			<firstname>DJ</firstname>
			<surname>Delorie</surname>
		</author>
		<author>
			<firstname>Pierre</firstname>
			<surname>Humblet</surname>
		</author>
		<author>
			<firstname>Geoffrey</firstname>
			<surname>Noer</surname>
		</author>
	</authorgroup>

	<xi:include href="legal.xml"/>
</bookinfo>

--------------020602000108030501060005
Content-Type: text/x-patch;
 name="cygdoc-build.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygdoc-build.patch"
Content-length: 4509

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/doc/Makefile.in,v
retrieving revision 1.28
diff -u -p -r1.28 Makefile.in
--- Makefile.in	23 Apr 2013 15:49:08 -0000	1.28
+++ Makefile.in	29 Apr 2013 23:14:03 -0000
@@ -12,7 +12,7 @@ SHELL = @SHELL@
 srcdir = @srcdir@
 VPATH = @srcdir@
 
-SGMLDIRS =  -d $(srcdir) -d $(srcdir)/../utils -d $(srcdir)/../cygwin
+DBXDIRS =  -d $(srcdir) -d $(srcdir)/../utils -d $(srcdir)/../cygwin
 
 CC:=@CC@
 CC_FOR_TARGET:=@CC@
@@ -22,70 +22,59 @@ XMLTO:=xmlto --skip-validation --with-db
 
 include $(srcdir)/../Makefile.common
 
-TOCLEAN:=faq.txt ./*.html readme.txt doctool.o doctool.exe *.junk \
-	 cygwin-ug.sgml cygwin-ug cygwin-ug-net.html.gz \
-	 cygwin-ug-net.sgml cygwin-ug-net cygwin-ug-net.html \
-	 cygwin-api.sgml cygwin-api cygwin-api-int.sgml cygwin-api-int \
-	 faq
-
-FAQ_SOURCES:= faq-api.xml faq-programming.xml faq-resources.xml \
-	      faq-sections.xml faq-setup.xml faq-using.xml faq-what.xml faq.xml
+FAQ_SOURCES:= faq*.xml
 
 .SUFFIXES:
 
-all : \
+all: Makefile \
 	cygwin-ug-net/cygwin-ug-net.html \
 	cygwin-ug-net/cygwin-ug-net-nochunks.html.gz \
 	cygwin-api/cygwin-api.html \
-	faq/faq.html faq/faq-nochunks.html \
+	faq/faq.html \
 	cygwin-ug-net/cygwin-ug-net.pdf \
 	cygwin-api/cygwin-api.pdf
 
 clean:
-	rm -Rf $(TOCLEAN)
+	rm -f doctool.exe doctool.o
+	rm -f cygwin-api.xml
+	rm -f *.html *.html.gz
+	rm -Rf cygwin-api cygwin-ug cygwin-ug-net faq
 
 install:	all
 
-cygwin-ug-net/cygwin-ug-net-nochunks.html.gz : cygwin-ug-net.sgml doctool
-	-${XMLTO} html-nochunks -m $(srcdir)/cygwin.dsl $<
+cygwin-ug-net/cygwin-ug-net-nochunks.html.gz : cygwin-ug-net.xml
+	-${XMLTO} html-nochunks -m $(srcdir)/cygwin.xsl $<
 	-cp cygwin-ug-net.html cygwin-ug-net/cygwin-ug-net-nochunks.html
 	-rm -f cygwin-ug-net/cygwin-ug-net-nochunks.html.gz
 	-gzip cygwin-ug-net/cygwin-ug-net-nochunks.html
 
-cygwin-ug-net/cygwin-ug-net.html : cygwin-ug-net.sgml doctool
-	-${XMLTO} html -o cygwin-ug-net/ -m $(srcdir)/cygwin.dsl $<
+cygwin-ug-net/cygwin-ug-net.html : cygwin-ug-net.xml
+	-${XMLTO} html -o cygwin-ug-net/ -m $(srcdir)/cygwin.xsl $<
 
 # Some versions of jw hang with the -o option
-cygwin-ug-net/cygwin-ug-net.pdf : cygwin-ug-net.sgml
+cygwin-ug-net/cygwin-ug-net.pdf : cygwin-ug-net.xml
 	-${XMLTO} pdf -o cygwin-ug-net/ $<
 
-cygwin-ug-net.sgml : cygwin-ug-net.in.sgml ./doctool Makefile
-	-./doctool -m $(SGMLDIRS) -s $(srcdir) -o $@ $<
-
-cygwin-api/cygwin-api.html : cygwin-api.sgml
-	-${XMLTO} html -o cygwin-api/ -m $(srcdir)/cygwin.dsl $<
+cygwin-api/cygwin-api.html : cygwin-api.xml
+	-${XMLTO} html -o cygwin-api/ -m $(srcdir)/cygwin.xsl $<
 
-cygwin-api/cygwin-api.pdf : cygwin-api.sgml
+cygwin-api/cygwin-api.pdf : cygwin-api.xml
 	-${XMLTO} pdf -o cygwin-api/ $<
 
-cygwin-api.sgml : cygwin-api.in.sgml ./doctool Makefile
-	-./doctool -m $(SGMLDIRS) -s $(srcdir) -o $@ $<
+cygwin-api.xml : cygwin-api.in.xml ./doctool Makefile
+	-./doctool -m $(DBXDIRS) -s $(srcdir) -o $@ $<
 
 faq/faq.html : $(FAQ_SOURCES)
-	-${XMLTO} html -o faq -m $(srcdir)/cygwin.dsl $(srcdir)/faq-sections.xml
-	-sed -i 's;</a><a name="id[0-9]*"></a>;</a>;g' faq/faq.*.html
-
-faq/faq-nochunks.html : $(FAQ_SOURCES)
-	-${XMLTO} html -o faq -m $(srcdir)/cygwin.dsl $(srcdir)/faq.xml
-	-sed -i 's;</a><a name="id[0-9]*"></a>;</a>;g' faq/faq-nochunks.html
+	-${XMLTO} html -o faq -m $(srcdir)/cygwin.xsl $(srcdir)/faq.xml
+	-sed -i 's;</a><a name="id[0-9]*"></a>;</a>;g' faq/faq.html
 
 ./doctool : doctool.c
 	gcc -g $< -o $@
 
 TBFILES = cygwin-ug-net.dvi cygwin-ug-net.rtf cygwin-ug-net.ps \
-	  cygwin-ug-net.pdf cygwin-ug-net.sgml \
+	  cygwin-ug-net.pdf cygwin-ug-net.xml \
 	  cygwin-api.dvi cygwin-api.rtf cygwin-api.ps \
-	  cygwin-api.pdf cygwin-api.sgml
+	  cygwin-api.pdf cygwin-api.xml
 TBDIRS = cygwin-ug-net cygwin-api
 TBDEPS = cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
 
Index: configure.ac
===================================================================
RCS file: /cvs/src/src/winsup/doc/configure.ac,v
retrieving revision 1.1
diff -u -p -r1.1 configure.ac
--- configure.ac	26 Nov 2012 19:50:44 -0000	1.1
+++ configure.ac	29 Apr 2013 23:14:03 -0000
@@ -10,7 +10,7 @@ dnl details.
 dnl Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.59)
-AC_INIT(cygwin-api.in.sgml)
+AC_INIT(cygwin-api.in.xml)
 AC_CONFIG_AUX_DIR(../..)
 
 AC_NO_EXECUTABLES
@@ -21,3 +21,4 @@ LIB_AC_PROG_CC
 AC_SUBST(build_exeext)
 
 AC_OUTPUT(Makefile)
+

--------------020602000108030501060005
Content-Type: text/x-patch;
 name="cygdoc-changelog.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygdoc-changelog.patch"
Content-length: 2437

Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/doc/ChangeLog,v
retrieving revision 1.429
diff -p -u -r1.429 ChangeLog
--- ChangeLog	25 Apr 2013 10:16:01 -0000	1.429
+++ ChangeLog	30 Apr 2013 00:24:03 -0000
@@ -1,3 +1,41 @@
+2013-04-29  Warren Young  <warren@etr-usa.com>
+
+	* cygwin-ug.xml: Renamed from cygwin-ug.in.sgml
+	(bookinfo) Extracted <bookinfo> section into new ug-info.xml file
+	* ug-info.xml: Created
+	* cygwin-ug-net.xml: Renamed from cygwin-ug-net.in.sgml
+	(bookinfo) Replaced content with XInclude referencing ug-info.xml
+	* configure.ac: Replaced a *.sgml file reference with *.xml
+	* cygserver.xml cygwinenv.xml dll.xml effectively.xml filemodes.xml
+	gcc.xml gdb.xml legal.xml new-features.xml ntsec.xml overview.xml
+	pathnames.xml programming.xml setup.xml setup-net.xml textbinary.xml
+	using.xml windres.xml: Renamed from *.sgml.
+	Added <?xml> and <!DOCTYPE> tags to the top.
+	* cygserver.sgml cygwinenv.sgml dll.sgml effectively.sgml filemodes.sgml
+	gcc.sgml gdb.sgml legal.sgml new-features.sgml ntsec.sgml overview.sgml
+	pathnames.sgml programming.sgml setup.sgml setup-net.sgml textbinary.sgml
+	using.sgml windres.sgml: Renamed to *.xml
+	* faq.xml: Renamed from faq-sections.sgml.  (Not faq.sgml!)
+	Replaced FAQ section ENTITY declarations XIncludes.
+	Removed all other ENTITY declarations as they just name entities
+	already defined in the current DocBook stylesheets.
+	* faq.sgml: Removed without translating to DocBook XML.  Obsolete.
+	* faq-*.xml: Added <?xml> and <!DOCTYPE> tags to the top.
+	Moved <qandadiv> tags from faq.xml and faq-sections.xml into
+	individual section files so they individually pass XML validation.
+	* pathnames.xml: Contained two top-level <sect1> elements, which is
+	malformed XML. Moved second to new specialnames.xml file.
+	* specialnames.xml: Created; extracted from pathnames.sgml
+	* overview2.xml: Broke it up into following three files, and
+	removed the original.
+	* ov-ex-win.xml (ov-ex-win): New file, contents extracted from
+	<sect1> in overview2.xml
+	* ov-ex-unix.xml (ov-ex-unix): Ditto
+	* highlights.xml (highlights): Ditto
+	* setup2.xml: Broke it up into setup-*.xml.
+	* setup-env.xml setup-files.xml setup-locale.xml setup-maxmem.xml:
+	Created
+
 2013-04-24  Corinna Vinschen  <corinna@vinschen.de>
 
 	* faq-programming.xml (faq.programming.64bitporting): Fix typo.

--------------020602000108030501060005
Content-Type: text/x-patch;
 name="cygdoc-sgml-to-xml.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygdoc-sgml-to-xml.patch"
Content-length: 37272

--- cygserver.sgml	2013-04-26 18:35:11.084803300 -0600
+++ cygserver.xml	2013-04-26 18:24:54.503110200 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <sect1 id="using-cygserver"><title>Cygserver</title>
 
 <sect2 id="what-is-cygserver"><title>What is Cygserver?</title>
--- cygwin-api.in.sgml	2013-04-26 18:35:11.100403600 -0600
+++ cygwin-api.in.xml	2013-04-26 20:51:25.662339700 -0600
@@ -1,15 +1,13 @@
-<?xml version="1.0"?>
-<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook XML V4.5//EN"
-"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" []>
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE book PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
 
-<book id="cygwin-api">
+<book id="cygwin-api" xmlns:xi="http://www.w3.org/2001/XInclude">
 
   <bookinfo>
     <date>1998-08-31</date>
     <title>Cygwin API Reference</title>
-
-    DOCTOOL-INSERT-legal
-
+		<xi:include href="legal.xml"/>
   </bookinfo>
 
   <toc></toc>
--- cygwinenv.sgml	2013-04-26 18:35:11.303206300 -0600
+++ cygwinenv.xml	2013-04-26 18:25:25.594277500 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <sect1 id="using-cygwinenv"><title>The <envar>CYGWIN</envar> environment
 variable</title>
 
--- dll.sgml	2013-04-26 18:35:11.303206300 -0600
+++ dll.xml	2013-04-26 18:25:31.069942200 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <sect1 id="dll"><title>Building and Using DLLs</title>
 
 <para>DLLs are Dynamic Link Libraries, which means that they're linked
--- effectively.sgml	2013-04-26 18:35:11.474808100 -0600
+++ effectively.xml	2013-04-26 18:25:48.432947600 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <sect1 id="using-effectively">
 <title>Using Cygwin effectively with Windows</title>
 
--- filemodes.sgml	2013-04-26 18:35:11.490408700 -0600
+++ filemodes.xml	2013-04-26 18:26:12.831634400 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <sect1 id="using-filemodes"><title>File permissions</title>
 
 <para>On FAT or FAT32 filesystems, files are always readable, and Cygwin
--- gcc.sgml	2013-04-26 18:35:11.506008200 -0600
+++ gcc.xml	2013-04-26 18:26:14.625655000 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <sect1 id="gcc"><title>Using GCC with Cygwin</title>
 
 <sect2 id="gcc-cons"><title>Console Mode Applications</title>
--- gdb.sgml	2013-04-26 18:35:11.506008200 -0600
+++ gdb.xml	2013-04-26 18:26:16.404075800 -0600
@@ -1,3 +1,6 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
 
 <sect1 id="gdb"><title>Debugging Cygwin Programs</title>
 
--- legal.sgml	2013-04-26 18:35:11.521608800 -0600
+++ legal.xml	2013-04-26 18:26:18.541303500 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE legalnotice PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <legalnotice id="legal">
 
 <para>Copyright &copy; 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012 Red Hat, Inc.</para>
--- new-features.sgml	2013-04-26 18:35:11.693210200 -0600
+++ new-features.xml	2013-04-26 18:26:20.475725800 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <sect1 id="ov-new1.7"><title>What's new and what changed in Cygwin 1.7</title>
 
 <sect2 id="ov-new1.7.19"><title>What's new and what changed from 1.7.18 to 1.7.19</title>
--- ntsec.sgml	2013-04-26 18:35:11.896012500 -0600
+++ ntsec.xml	2013-04-26 18:26:22.441351400 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <sect1 id="ntsec"><title>Using Windows security in Cygwin</title>
 
 <para>This section discusses how the Windows security model is
--- overview.sgml	2013-04-26 18:35:11.911612800 -0600
+++ overview.xml	2013-04-26 20:51:42.416934700 -0600
@@ -1,4 +1,9 @@
-<chapter id="overview"><title>Cygwin Overview</title>
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE chapter PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+    "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
+<chapter id="overview" xmlns:xi="http://www.w3.org/2001/XInclude">
+<title>Cygwin Overview</title>
 
 <sect1 id="what-is-it"><title>What is it?</title>
 
@@ -29,8 +34,8 @@ distribution).
 </para>
 </sect1>
 
-DOCTOOL-INSERT-ov-ex-win
-DOCTOOL-INSERT-ov-ex-unix
+<xi:include href="ov-ex-win.xml"/>
+<xi:include href="ov-ex-unix.xml"/>
 
 <sect1 id="are-free"><title>Are the Cygwin tools free software?</title>
 
@@ -120,7 +125,7 @@ available in a 64 bit version is 1.7.19.
 
 </sect1>
 
-DOCTOOL-INSERT-highlights
-DOCTOOL-INSERT-ov-new1.7
+<xi:include href="highlights.xml"/>
+<xi:include href="new-features.xml"/>
 
 </chapter>
--- pathnames.sgml	2013-04-26 18:35:12.239216200 -0600
+++ pathnames.xml	2013-04-26 18:29:38.598071300 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <sect1 id="using-pathnames"><title>Mapping path names</title>
 
 <sect2 id="pathnames-intro"><title>Introduction</title>
@@ -489,517 +493,3 @@ not by default, for example).</para>
 </sect2>
 
 </sect1>
-
-<sect1 id="using-specialnames"><title>Special filenames</title>
-
-<sect2 id="pathnames-etc"><title>Special files in /etc</title>
-
-<para>Certain files in Cygwin's <filename>/etc</filename> directory are
-read by Cygwin before the mount table has been established.  The list
-of files is</para>
-
-<screen>
-  /etc/fstab
-  /etc/fstab.d/$USER
-  /etc/passwd
-  /etc/group
-</screen>
-
-<para>These file are read using native Windows NT functions which have
-no notion of Cygwin symlinks or POSIX paths.  For that reason
-there are a few requirements as far as <filename>/etc</filename> is
-concerned.</para>
-
-<para>To access these files, the Cygwin DLL evaluates it's own full
-Windows path, strips off the innermost directory component and adds
-"\etc".  Let's assume the Cygwin DLL is installed as
-<filename>C:\cygwin\bin\cygwin1.dll</filename>.  First the DLL name as
-well as the innermost directory (<filename>bin</filename>) is stripped
-off: <filename>C:\cygwin\</filename>.  Then "etc" and the filename to
-look for is attached: <filename>C:\cygwin\etc\fstab</filename>.  So the
-/etc directory must be parallel to the directory in which the cygwin1.dll
-exists and <filename>/etc</filename> must not be a Cygwin symlink
-pointing to another directory.  Consequentially none of the files from
-the above list, including the directory <filename>/etc/fstab.d</filename>
-is allowed to be a Cygwin symlink either.</para>
-
-<para>However, native NTFS symlinks and reparse points are transparent
-when accessing the above files so all these files as well as
-<filename>/etc</filename> itself may be NTFS symlinks or reparse
-points.</para>
-
-<para>Last but not least, make sure that these files are world-readable.
-Every process of any user account has to read these files potentially,
-so world-readability is essential.  The only exception are the user
-specific files <filename>/etc/fstab.d/$USER</filename>, which only have
-to be readable by the $USER user account itself.</para>
-
-</sect2>
-
-<sect2 id="pathnames-dosdevices"><title>Invalid filenames</title>
-
-<para>Filenames invalid under Win32 are not necessarily invalid
-under Cygwin since release 1.7.0.  There are a few rules which
-apply to Windows filenames.  Most notably, DOS device names like
-<filename>AUX</filename>, <filename>COM1</filename>,
-<filename>LPT1</filename> or <filename>PRN</filename> (to name a few)
-cannot be used as filename or extension in a native Win32 application.
-So filenames like <filename>prn.txt</filename> or <filename>foo.aux</filename>
-are invalid filenames for native Win32 applications.</para>
-
-<para>This restriction doesn't apply to Cygwin applications.  Cygwin
-can create and access files with such names just fine.  Just don't try
-to use these files with native Win32 applications.</para>
-
-</sect2>
-
-<sect2 id="pathnames-specialchars">
-<title>Forbidden characters in filenames</title>
-
-<para>Some characters are disallowed in filenames on Windows filesystems.
-These forbidden characters are the ASCII control characters from ASCII
-value 1 to 31, plus the following characters which have a special meaning
-in the Win32 API:</para>
-
-<screen>
-  "   *   :   &lt;   &gt;   ?   |   \
-</screen>
-
-<para>Cygwin can't fix this, but it has a method to workaround this
-restriction.  All of the above characters, except for the backslash,
-are converted to special UNICODE characters in the range 0xf000 to 0xf0ff
-(the "Private use area") when creating or accessing files.</para>
-
-<para>The backslash has to be exempt from this conversion, because Cygwin
-accepts Win32 filenames including backslashes as path separators on input. 
-Converting backslashes using the above method would make this impossible.</para>
-
-<para>Additionally Win32 filenames can't contain trailing dots and spaces
-for DOS backward compatibility.  When trying to create files with trailing
-dots or spaces, all of them are removed before the file is created.  This
-restriction only affects native Win32 applications.  Cygwin applications
-can create and access files with trailing dots and spaces without problems.
-</para>
-
-<para>An exception from this rule are some network filesystems (NetApp,
-NWFS) which choke on these filenames.  They return with an error like
-"No such file or directory" when trying to create such files.  Starting
-with Cygwin 1.7.6, Cygwin recognizes these filesystems and works around
-this problem by applying the same rule as for the other forbidden characters. 
-Leading spaces and trailing dots and spaces will be converted to UNICODE
-characters in the private use area.  This behaviour can be switched on
-explicitely for a filesystem or a directory tree by using the mount option
-<literal>dos</literal>.</para>
-
-</sect2>
-
-<sect2 id="pathnames-unusual">
-<title>Filenames with unusual (foreign) characters</title>
-
-<para> Windows filesystems use Unicode encoded as UTF-16
-to store filename information.  If you don't use the UTF-8
-character set (see <xref linkend="setup-locale"></xref>) then there's a
-chance that a filename is using one or more characters which have no
-representation in the character set you're using.</para>
-
-<note><para>In the default "C" locale, Cygwin creates filenames using
-the UTF-8 charset.  This will always result in some valid filename by
-default, but again might impose problems when switching to a non-"C"
-or non-"UTF-8" charset.</para></note>
-
-<note><para>To avoid this scenario altogether, always use UTF-8 as the
-character set.</para></note>
-
-<para>If you don't want or can't use UTF-8 as character set for whatever
-reason, you will nevertheless be able to access the file.  How does that
-work?  When Cygwin converts the filename from UTF-16 to your character
-set, it recognizes characters which can't be converted.  If that occurs,
-Cygwin replaces the non-convertible character with a special character
-sequence.  The sequence starts with an ASCII CAN character (hex code
-0x18, equivalent Control-X), followed by the UTF-8 representation of the
-character.  The result is a filename containing some ugly looking
-characters.  While it doesn't <emphasis role='bold'>look</emphasis> nice, it
-<emphasis role='bold'>is</emphasis> nice, because Cygwin knows how to convert
-this filename back to UTF-16.  The filename will be converted using your
-usual character set.  However, when Cygwin recognizes an ASCII CAN
-character, it skips over the ASCII CAN and handles the following bytes as
-a UTF-8 character.  Thus, the filename is symmetrically converted back to
-UTF-16 and you can access the file.</para>
-
-<note><para>Please be aware that this method is not entirely foolproof.
-In some character set combinations it might not work for certain native
-characters.</para>
-
-<para>Only by using the UTF-8 charset you can avoid this problem safely.
-</para></note>
-
-</sect2>
-
-<sect2 id="pathnames-casesensitive">
-<title>Case sensitive filenames</title>
-
-<para>In the Win32 subsystem filenames are only case-preserved, but not
-case-sensitive.  You can't access two files in the same directory which
-only differ by case, like <filename>Abc</filename> and
-<filename>aBc</filename>.  While NTFS (and some remote filesystems)
-support case-sensitivity, the NT kernel starting with Windows XP does
-not support it by default.  Rather, you have to tweak a registry setting
-and reboot.  For that reason, case-sensitivity can not be supported by Cygwin,
-unless you change that registry value.</para>
-
-<para>If you really want case-sensitivity in Cygwin, you can switch it
-on by setting the registry value</para>
-
-<screen>
-HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel\obcaseinsensitive
-</screen>
-
-<para>to 0 and reboot the machine.</para>
-
-<note>
-<para>
-When installing Microsoft's Services For Unix (SFU), you're asked if
-you want to use case-sensitive filenames.  If you answer "yes" at this point,
-the installer will change the aforementioned registry value to 0, too.  So, if
-you have SFU installed, there's some chance that the registry value is already
-set to case sensitivity.
-</para>
-</note>
-
-<para>After you set this registry value to 0, Cygwin will be case-sensitive
-by default on NTFS and NFS filesystems.  However, there are limitations: 
-while two <emphasis role='bold'>programs</emphasis> <filename>Abc.exe</filename>
-and <filename>aBc.exe</filename> can be created and accessed like other files,
-starting applications is still case-insensitive due to Windows limitations
-and so the program you try to launch may not be the one actually started.  Also,
-be aware that using two filenames which only differ by case might
-result in some weird interoperability issues with native Win32 applications.  
-You're using case-sensitivity at your own risk.  You have been warned! </para>
-
-<para>Even if you use case-sensitivity, it might be feasible to switch to
-case-insensitivity for certain paths for better interoperability with
-native Win32 applications (even if it's just Windows Explorer).  You can do
-this on a per-mount point base, by using the "posix=0" mount option in
-<filename>/etc/fstab</filename>, or your <filename>/etc/fstab.d/$USER</filename>
-file.</para>
-
-<para><filename>/cygdrive</filename> paths are case-insensitive by default.
-The reason is that the native Windows %PATH% environment variable is not
-always using the correct case for all paths in it.  As a result, if you use
-case-sensitivity on the <filename>/cygdrive</filename> prefix, your shell
-might claim that it can't find Windows commands like <command>attrib</command>
-or <command>net</command>.  To ease the pain, the <filename>/cygdrive</filename>
-path is case-insensitive by default and you have to use the "posix=1" setting
-explicitly in <filename>/etc/fstab</filename> or
-<filename>/etc/fstab.d/$USER</filename> to switch it to case-sensitivity,
-or you have to make sure that the native Win32 %PATH% environment variable
-is using the correct case for all paths throughout.</para>
-
-<para>Note that mount points as well as device names and virtual
-paths like /proc are always case-sensitive!  The only exception are
-the subdirectories and filenames under /proc/registry, /proc/registry32
-and /proc/registry64.  Registry access is always case-insensitive.
-Read on for more information.</para>
-
-</sect2>
-
-<sect2 id="pathnames-posixdevices"> <title>POSIX devices</title>
-<para>While there is no need to create a POSIX <filename>/dev</filename> 
-directory, the directory is automatically created as part of a Cygwin
-installation.  It's existence is often a prerequisit to run certain
-applications which create symbolic links, fifos, or UNIX sockets in
-<filename>/dev</filename>.  Also, the directories <filename>/dev/shm</filename>
-and <filename>/dev/mqueue</filename> are required to exist to use named POSIX
-semaphores, shared memory, and message queues, so a system without a real
-<filename>/dev</filename> directory is functionally crippled.
-</para>
-
-<para>Apart from that, Cygwin automatically simulates POSIX devices
-internally.  Up to Cygwin 1.7.11, these devices couldn't be seen with the
-command <command>ls /dev/</command> although commands such as
-<command>ls /dev/tty</command> worked fine.  Starting with Cygwin 1.7.12,
-the <filename>/dev</filename> directory is automagically populated with
-existing POSIX devices by Cygwin in a way comparable with a
-<ulink url="http://en.wikipedia.org/wiki/Udev">udev</ulink> based virtual
-<filename>/dev</filename> directory under Linux.</para>
-
-<para>
-Cygwin supports the following character devices commonly found on POSIX systems:
-</para>
-
-<screen>
-/dev/null
-/dev/zero
-/dev/full
-
-/dev/console	Pseudo device name for the current console window of a session.
-		Up to Cygwin 1.7.9, this was the only name for a console.
-		Different consoles were indistinguishable.
-		Cygwin's /dev/console is not quite comparable with the console
-		device on UNIX machines.
-
-/dev/cons0      Starting with Cygwin 1.7.10, Console sessions are numbered from 
-/dev/cons1	/dev/cons0 upwards.  Console device names are pseudo device
-...		names, only accessible from processes within this very console
-		session.  This is due to a restriction in Windows.
-
-/dev/tty	The current controlling tty of a session.
-
-/dev/ptmx	Pseudo tty master device.
-
-/dev/pty0	Pseudo ttys are numbered from /dev/pty0 upwards as they are
-/dev/pty1	requested.
-...
-
-/dev/ttyS0	Serial communication devices.  ttyS0 == Win32 COM1,
-/dev/ttyS1	ttyS1 == COM2, etc.
-...
-
-/dev/pipe
-/dev/fifo
-
-/dev/mem	The physical memory of the machine.  Note that access to the
-/dev/port	physical memory has been restricted with Windows Server 2003.
-/dev/kmem	Since this OS, you can't access physical memory from user space.
-
-/dev/kmsg	Kernel message pipe, for usage with sys logger services.
-
-/dev/random	Random number generator.
-/dev/urandom
-
-/dev/dsp	Default sound device of the system.
-</screen>
-
-<para>
-Cygwin also has several Windows-specific devices:
-</para>
-
-<screen>
-/dev/com1	The serial ports, starting with COM1 which is the same as ttyS0.
-/dev/com2	Please use /dev/ttySx instead.
-...
-
-/dev/conin	Same as Windows CONIN$.
-/dev/conout	Same as Windows CONOUT$.
-/dev/clipboard	The Windows clipboard, text only
-/dev/windows	The Windows message queue.
-</screen>
-
-<para>
-Block devices are accessible by Cygwin processes using fixed POSIX device
-names.  These POSIX device names are generated using a direct conversion
-from the POSIX namespace to the internal NT namespace.
-E.g. the first harddisk is the NT internal device \device\harddisk0\partition0
-or the first partition on the third harddisk is \device\harddisk2\partition1.
-The first floppy in the system is \device\floppy0, the first CD-ROM is
-\device\cdrom0 and the first tape drive is \device\tape0.</para>
-
-<para>The mapping from physical device to the name of the device in the
-internal NT namespace can be found in various places.  For hard disks and
-CD/DVD drives, the Windows "Disk Management" utility (part of the
-"Computer Management" console) shows that the mapping of "Disk 0" is
-\device\harddisk0.  "CD-ROM 2" is \device\cdrom2.  Another place to find
-this mapping is the "Device Management" console.  Disks have a
-"Location" number, tapes have a "Tape Symbolic Name", etc.
-Unfortunately, the places where this information is found is not very
-well-defined.</para>
-
-<para>
-For external disks (USB-drives, CF-cards in a cardreader, etc) you can use
-Cygwin to show the mapping.  <filename>/proc/partitions</filename>
-contains a list of raw drives known to Cygwin.  The <command>df</command>
-command shows a list of drives and their respective sizes.  If you match
-the information between <filename>/proc/partitions</filename> and the
-<command>df</command> output, you should be able to figure out which
-external drive corresponds to which raw disk device name.</para>
-
-<note><para>Apart from tape devices which are not block devices and are
-by default accessed directly, accessing mass storage devices raw
-is something you should only do if you know what you're doing and know how to
-handle the information.  <emphasis role='bold'>Writing</emphasis> to a raw
-mass storage device you should only do if you
-<emphasis role='bold'>really</emphasis> know what you're doing and are aware
-of the fact that any mistake can destroy important information, for the
-device, and for you.  So, please, handle this ability with care.
-<emphasis role='bold'>You have been warned.</emphasis></para></note>
-
-<para>
-Last but not least, the mapping from POSIX /dev namespace to internal
-NT namespace is as follows:
-</para>
-
-<screen>
-POSIX device name     Internal NT device name
-
-/dev/st0	      \device\tape0, rewind
-/dev/nst0	      \device\tape0, no-rewind
-/dev/st1	      \device\tape1
-/dev/nst1	      \device\tape1
-...
-/dev/st15
-/dev/nst15
-
-/dev/fd0	      \device\floppy0
-/dev/fd1	      \device\floppy1
-...
-/dev/fd15
-
-/dev/sr0	      \device\cdrom0
-/dev/sr1	      \device\cdrom1
-...
-/dev/sr15
-
-/dev/scd0	      \device\cdrom0
-/dev/scd1	      \device\cdrom1
-...
-/dev/scd15
-
-/dev/sda	      \device\harddisk0\partition0	(whole disk)
-/dev/sda1	      \device\harddisk0\partition1	(first partition)
-...
-/dev/sda15	      \device\harddisk0\partition15	(fifteenth partition)
-
-/dev/sdb	      \device\harddisk1\partition0
-/dev/sdb1	      \device\harddisk1\partition1
-
-[up to]
-
-/dev/sddx	      \device\harddisk127\partition0
-/dev/sddx1	      \device\harddisk127\partition1
-...
-/dev/sddx15	      \device\harddisk127\partition15
-</screen>
-
-<para>
-if you don't like these device names, feel free to create symbolic
-links as they are created on Linux systems for convenience:
-</para>
-
-<screen>
-ln -s /dev/sr0 /dev/cdrom
-ln -s /dev/nst0 /dev/tape
-...
-</screen>
-
-</sect2>
-
-<sect2 id="pathnames-exe"><title>The .exe extension</title>
-
-<para>Win32 executable filenames end with <filename>.exe</filename>
-but the <filename>.exe</filename> need not be included in the command,
-so that traditional UNIX names can be used.  However, for programs that
-end in <filename>.bat</filename> and <filename>.com</filename>, you
-cannot omit the extension.  </para>
-
-<para>As a side effect, the <command> ls filename</command> gives
-information about <filename>filename.exe</filename> if
-<filename>filename.exe</filename> exists and <filename>filename</filename>
-does not.  In the same situation the function call
-<function>stat("filename",..)</function> gives information about
-<filename>filename.exe</filename>.  The two files can be distinguished
-by examining their inodes, as demonstrated below.
-<screen>
-<prompt>bash$</prompt> <userinput>ls * </userinput>
-a      a.exe     b.exe
-<prompt>bash$</prompt> <userinput>ls -i a a.exe</userinput>
-445885548 a       435996602 a.exe
-<prompt>bash$</prompt> <userinput>ls -i b b.exe</userinput>
-432961010 b       432961010 b.exe
-</screen>
-If a shell script <filename>myprog</filename> and a program
-<filename>myprog.exe</filename> coexist in a directory, the shell
-script has precedence and is selected for execution of
-<command>myprog</command>.  Note that this was quite the reverse up to
-Cygwin 1.5.19.  It has been changed for consistency with the rest of Cygwin.
-</para>
-
-<para>The <command>gcc</command> compiler produces an executable named
-<filename>filename.exe</filename> when asked to produce
-<filename>filename</filename>. This allows many makefiles written
-for UNIX systems to work well under Cygwin.</para>
-
-</sect2>
-
-<sect2 id="pathnames-proc"><title>The /proc filesystem</title> 
-<para>
-Cygwin, like Linux and other similar operating systems, supports the
-<filename>/proc</filename> virtual filesystem. The files in this
-directory are representations of various aspects of your system,
-for example the command <userinput>cat /proc/cpuinfo</userinput> 
-displays information such as what model and speed processor you have.
-</para>
-<para>
-One unique aspect of the Cygwin <filename>/proc</filename> filesystem
-is <filename>/proc/registry</filename>, see next section.
-</para>
-<para>
-The Cygwin <filename>/proc</filename> is not as complete as the
-one in Linux, but it provides significant capabilities. The
-<systemitem>procps</systemitem> package contains several utilities
-that use it.
-</para>
-</sect2>
-
-<sect2 id="pathnames-proc-registry"><title>The /proc/registry filesystem</title>
-<para>
-The <filename>/proc/registry</filename> filesystem provides read-only
-access to the Windows registry.  It displays each <literal>KEY</literal>
-as a directory and each <literal>VALUE</literal> as a file.  As anytime
-you deal with the Windows registry, use caution since changes may result
-in an unstable or broken system.  There are additionally subdirectories called
-<filename>/proc/registry32</filename> and <filename>/proc/registry64</filename>.
-They are identical to <filename>/proc/registry</filename> on 32 bit
-host OSes.  On 64 bit host OSes, <filename>/proc/registry32</filename>
-opens the 32 bit processes view on the registry, while
-<filename>/proc/registry64</filename> opens the 64 bit processes view.
-</para>
-<para>
-Reserved characters ('/', '\', ':', and '%') or reserved names
-(<filename>.</filename> and <filename>..</filename>) are converted by
-percent-encoding:
-<screen>
-<prompt>bash$</prompt> <userinput>regtool list -v '\HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices'</userinput>
-...
-\DosDevices\C: (REG_BINARY) = cf a8 97 e8 00 08 fe f7
-...
-<prompt>bash$</prompt> <userinput>cd /proc/registry/HKEY_LOCAL_MACHINE/SYSTEM</userinput>
-<prompt>bash$</prompt> <userinput>ls -l MountedDevices</userinput>
-...
--r--r----- 1 Admin SYSTEM  12 Dec 10 11:20 %5CDosDevices%5CC%3A
-...
-<prompt>bash$</prompt> <userinput>od -t x1 MountedDevices/%5CDosDevices%5CC%3A</userinput>
-0000000 cf a8 97 e8 00 08 fe f7 01 00 00 00
-</screen>
-The unnamed (default) value of a key can be accessed using the filename
-<filename>@</filename>.
-</para>
-<para>
-If a registry key contains a subkey and a value with the same name
-<filename>foo</filename>, Cygwin displays the subkey as
-<filename>foo</filename> and the value as <filename>foo%val</filename>.
-</para>
-</sect2>
-
-<sect2 id="pathnames-at"><title>The @pathnames</title> 
-<para>To circumvent the limitations on shell line length in the native
-Windows command shells, Cygwin programs, when invoked by non-Cygwin processes, expand their arguments
-starting with "@" in a special way.  If a file
-<filename>pathname</filename> exists, the argument
-<filename>@pathname</filename> expands recursively to the content of
-<filename>pathname</filename>. Double quotes can be used inside the
-file to delimit strings containing blank space. 
-In the following example compare the behaviors
-<command>/bin/echo</command> when run from bash and from the Windows command prompt.</para>
-
-<example id="pathnames-at-ex"><title> Using @pathname</title>
-<screen>
-<prompt>bash$</prompt> <userinput>/bin/echo  'This   is   "a     long"  line' > mylist</userinput>
-<prompt>bash$</prompt> <userinput>/bin/echo @mylist</userinput>
-@mylist
-<prompt>bash$</prompt> <userinput>cmd</userinput>
-<prompt>c:\&gt;</prompt> <userinput>c:\cygwin\bin\echo @mylist</userinput>
-This is a     long line
-</screen>
-</example>
-</sect2> 
-</sect1>
--- programming.sgml	2013-04-26 18:35:12.239216200 -0600
+++ programming.xml	2013-04-26 20:51:45.833377500 -0600
@@ -1,11 +1,12 @@
-<chapter id="programming"><title>Programming with Cygwin</title>
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE chapter PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
 
-DOCTOOL-INSERT-gcc
-
-DOCTOOL-INSERT-gdb
-
-DOCTOOL-INSERT-dll
-
-DOCTOOL-INSERT-windres
+<chapter id="programming" xmlns:xi="http://www.w3.org/2001/XInclude">
+	<title>Programming with Cygwin</title>
 
+	<xi:include href="gcc.xml"/>
+	<xi:include href="gdb.xml"/>
+	<xi:include href="dll.xml"/>
+	<xi:include href="windres.xml"/>
 </chapter>
--- setup.sgml	2013-04-26 18:35:12.317219300 -0600
+++ setup.xml	2013-04-26 20:51:48.906614800 -0600
@@ -1,4 +1,9 @@
-<chapter id="setup"><title>Setting Up Cygwin</title>
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE chapter PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
+<chapter id="setup" xmlns:xi="http://www.w3.org/2001/XInclude">
+<title>Setting Up Cygwin</title>
 
 <sect1><title>Cygwin Contents</title>
 
@@ -39,9 +44,9 @@ via the "Add/Remove Programs" control pa
 
 </sect1>
 
-DOCTOOL-INSERT-setup-dir
-DOCTOOL-INSERT-setup-env
-DOCTOOL-INSERT-ntsec
-DOCTOOL-INSERT-setup-reg
-DOCTOOL-INSERT-setup-mount
+<xi:include href="setup-dir.xml"/>
+<xi:include href="setup-env.xml"/>
+<xi:include href="ntsec.xml"/>
+<xi:include href="setup-reg.xml"/>
+<xi:include href="setup-mount.xml"/>
 </chapter>
--- setup-net.sgml	2013-04-26 18:35:12.301618300 -0600
+++ setup-net.xml	2013-04-26 20:51:58.063920300 -0600
@@ -1,4 +1,9 @@
-<chapter id="setup-net"><title>Setting Up Cygwin</title>
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE chapter PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
+<chapter id="setup-net" xmlns:xi="http://www.w3.org/2001/XInclude">
+<title>Setting Up Cygwin</title>
 
 <sect1 id="internet-setup">
 <title>Internet Setup</title>
@@ -257,8 +262,8 @@ Problems with Cygwin</ulink>.
 
 </sect1>
 
-DOCTOOL-INSERT-setup-env
-DOCTOOL-INSERT-setup-maxmem
-DOCTOOL-INSERT-setup-locale
-DOCTOOL-INSERT-setup-files
+<xi:include href="setup-env.xml"/>
+<xi:include href="setup-maxmem.xml"/>
+<xi:include href="setup-locale.xml"/>
+<xi:include href="setup-files.xml"/>
 </chapter>
--- textbinary.sgml	2013-04-26 18:35:12.379618300 -0600
+++ textbinary.xml	2013-04-26 18:26:36.403514900 -0600
@@ -1,3 +1,7 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
 <sect1 id="using-textbinary"><title>Text and Binary modes</title>
 
 <sect2 id="textbin-issue"> <title>The Issue</title>
--- using.sgml	2013-04-26 18:35:12.395218600 -0600
+++ using.xml	2013-04-26 20:53:25.502957300 -0600
@@ -1,25 +1,21 @@
-<chapter id="using"><title>Using Cygwin</title>
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE chapter PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
+<chapter id="using" xmlns:xi="http://www.w3.org/2001/XInclude">
+<title>Using Cygwin</title>
 
 <para>This chapter explains some key differences between the Cygwin
 environment and traditional UNIX systems. It assumes a working
 knowledge of standard UNIX commands.</para>
 
-DOCTOOL-INSERT-using-pathnames
-
-DOCTOOL-INSERT-using-textbinary
-
-DOCTOOL-INSERT-using-filemodes
-
-DOCTOOL-INSERT-using-specialnames
-
-DOCTOOL-INSERT-using-cygwinenv
-
-DOCTOOL-INSERT-ntsec
-
-DOCTOOL-INSERT-using-cygserver
-
-DOCTOOL-INSERT-using-utils
-
-DOCTOOL-INSERT-using-effectively
-
+	<xi:include href="pathnames.xml"/>
+	<xi:include href="textbinary.xml"/>
+	<xi:include href="filemodes.xml"/>
+	<xi:include href="specialnames.xml"/>
+	<xi:include href="cygwinenv.xml"/>
+	<xi:include href="ntsec.xml"/>
+	<xi:include href="cygserver.xml"/>
+	<xi:include href="../utils/utils.xml"/>
+	<xi:include href="effectively.xml"/>
 </chapter>
--- windres.sgml	2013-04-26 18:35:12.426419000 -0600
+++ windres.xml	2013-04-26 18:26:45.092817500 -0600
@@ -1,3 +1,6 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
 
 <sect1 id="windres"><title>Defining Windows Resources</title>

--- faq-api.xml	26 Jan 2010 19:26:59 -0000	1.6
+++ faq-api.xml	30 Apr 2013 00:02:32 -0000
@@ -1,3 +1,10 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
+<qandadiv id="faq.api">
+<title>Cygwin API Questions</title>
+
 <!-- faq-api.xml --> 
 <qandaentry id="faq.api.everything">
 <question><para>How does everything work?</para></question>
@@ -319,4 +326,4 @@ In a Windows console window you can enab
 using the xterm escape sequences for mouse events.
 </para>
 </answer></qandaentry>
-
+</qandadiv>
--- faq-resources.xml	20 Jul 2009 10:10:48 -0000	1.4
+++ faq-resources.xml	30 Apr 2013 00:02:32 -0000
@@ -1,3 +1,10 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
+<qandadiv id="faq.resources">
+<title>Further Resources</title>
+
 <!-- faq-resources.xml -->
 <qandaentry id="faq.resources.documentation">
 <question><para>Where's the documentation?</para></question>
@@ -48,4 +55,4 @@ for a list of them.)
 <para>Comprehensive information about reporting problems with Cygwin can be found at <ulink url="http://cygwin.com/problems.html" />.
 </para>
 </answer></qandaentry>
-
+</qandadiv>
--- faq-programming.xml	25 Apr 2013 10:16:01 -0000	1.25
+++ faq-programming.xml	29 Apr 2013 23:14:04 -0000
@@ -1,5 +1,11 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
 <!-- faq-programming.xml -->
 
+<qandadiv id="faq.programming">
+<title>Programming Questions</title>
+
 <qandaentry id="faq.programming.packages">
 <question><para>How do I contribute a package?</para></question>
 <answer>
@@ -1107,3 +1113,5 @@ executable.</para></listitem>
 linker flag.</para></listitem>
 </orderedlist></listitem></orderedlist>
 </answer></qandaentry>
+
+</qandadiv>
--- faq-setup.xml	5 Jan 2011 16:02:00 -0000	1.28
+++ faq-setup.xml	30 Apr 2013 00:04:03 -0000
@@ -1,3 +1,10 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
+<qandadiv id="faq.setup">
+<title>Setting up Cygwin</title>
+
 <!-- faq-setup.xml -->
 <qandaentry id="faq.setup.setup">
 <question><para>What is the recommended installation procedure?</para></question>
@@ -604,4 +611,5 @@ this up for Cygwin 1.7, we might add thi
 except for the installation directory information stored there for the sake
 of setup.exe.  There's nothing left to manipulate anymore.
 </para></answer></qandaentry>
+</qandadiv>
 
--- faq-using.xml	23 Apr 2013 15:59:21 -0000	1.48
+++ faq-using.xml	29 Apr 2013 23:14:05 -0000
@@ -1,3 +1,10 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
+<qandadiv id="faq.using">
+<title>Using Cygwin</title>
+
 <!-- faq-problems.xml -->
 <qandaentry id="faq.using.missing-dlls">
 <question><para>Why can't my application locate cygncurses-8.dll?  or cygintl-3.dll?  or cygreadline6.dll?  or ...?</para></question>
@@ -1243,3 +1250,4 @@ such as virtual memory paging and file c
   difficult to make <literal>fork()</literal> work reliably.</para>
 </answer>
 </qandaentry>
+</qandadiv>
diff -u -p -r1.15 faq-what.xml
--- faq-what.xml	23 Apr 2013 09:44:36 -0000	1.15
+++ faq-what.xml	29 Apr 2013 23:14:05 -0000
@@ -1,5 +1,12 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
+		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
+
+<qandadiv id="faq.about">
+<title>About Cygwin</title>
+
 <!-- faq-what.xml -->
-<qandaentry id="faq.what">
+<qandaentry id="faq.what.what">
 <question><para>What is it?</para></question>
 <answer>
 
@@ -152,4 +159,4 @@ function, so some email will have to go 
 <para>Many thanks to everyone using the tools for their many contributions in
 the form of advice, bug reports, and code fixes.  Keep them coming!
 </para></answer></qandaentry>
-
+</qandadiv>

--------------020602000108030501060005
Content-Type: text/xml;
 name="faq.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="faq.xml"
Content-length: 642

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
    "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<article id="faq" lang="en" xmlns:xi="http://www.w3.org/2001/XInclude">
  <articleinfo>
    <title>Cygwin FAQ</title>
  </articleinfo>

  <qandaset>
    <?dbhtml toc="1"?>

    <xi:include href="faq-what.xml"/>
    <xi:include href="faq-setup.xml"/>
    <xi:include href="faq-resources.xml"/>
    <xi:include href="faq-using.xml"/>
    <xi:include href="faq-api.xml"/>
    <xi:include href="faq-programming.xml"/>
    <xi:include href="faq-copyright.xml"/>
  </qandaset>
</article>

--------------020602000108030501060005
Content-Type: text/xml;
 name="faq-copyright.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="faq-copyright.xml"
Content-length: 544

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
    "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">
<!-- faq-copyright.xml -->

<qandadiv id="faq.copyright">
  <title>Copyright</title>

  <qandaentry id="faq.what.copyright">
    <question><para>What are the copyrights?</para></question>

    <answer>
      <para>Please see <ulink url="http://cygwin.com/license.html"/>
      for more information about Cygwin copyright and licensing.</para>
    </answer>
  </qandaentry>
</qandadiv>

--------------020602000108030501060005
Content-Type: text/xml;
 name="highlights.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="highlights.xml"
Content-length: 21831

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<sect1 id="highlights"><title>Highlights of Cygwin Functionality</title>

<sect2 id="ov-hi-intro"><title>Introduction</title> <para>When a binary linked
against the library is executed, the Cygwin DLL is loaded into the
application's text segment.  Because we are trying to emulate a UNIX kernel
which needs access to all processes running under it, the first Cygwin DLL to
run creates shared memory areas and global synchronization objects that other
processes using separate instances of the DLL can access.  This is used to keep track of open file descriptors and to assist fork and exec, among other
purposes.  Every process also has a per_process structure that contains
information such as process id, user id, signal masks, and other similar
process-specific information.</para>

<para>The DLL is implemented as a standard DLL in the Win32 subsystem.  Under
the hood it's using the Win32 API, as well as the native NT API, where
appropriate.</para>

<note><para>Some restrictions apply for calls to the Win32 API.
For details, see <xref linkend="setup-env-win32"></xref>,
as well as <xref linkend="pathnames-win32-api"></xref>.</para></note>

<para>The native NT API is used mainly for speed, as well as to access
NT capabilities which are useful to implement certain POSIX features, but
are hidden to the Win32 API.
</para>

<para>Due to some restrictions in Windows, it's not always possible
to strictly adhere to existing UNIX standards like POSIX.1.  Fortunately
these are mostly corner cases.</para>

<para>Note that many of the things that Cygwin does to provide POSIX
compatibility do not mesh well with the native Windows API.  If you mix
POSIX calls with Windows calls in your program it is possible that you
will see uneven results.  In particular, Cygwin signals will not work
with Windows functions which block and Windows functions which accept
filenames may be confused by Cygwin's support for long filenames.</para>

</sect2>

<sect2 id="ov-hi-perm"><title>Permissions and Security</title>
<para>Windows NT includes a sophisticated security model based on Access
Control Lists (ACLs).  Cygwin maps Win32 file ownership and permissions to
ACLs by default, on file systems supporting them (usually NTFS).  Solaris
style ACLs and accompanying function calls are also supported.
The chmod call maps UNIX-style permissions back to the Win32 equivalents. 
Because many programs expect to be able to find the
<filename>/etc/passwd</filename> and
<filename>/etc/group</filename> files, we provide <ulink 
url="http://cygwin.com/cygwin-ug-net/using-utils.html">utilities</ulink>
that can be used to construct them from the user and group information
provided by the operating system.</para>

<para>Users with Administrator rights are permitted to chown files.
With version 1.1.3 Cygwin introduced a mechanism for setting real and
effective UIDs. This is described in <xref linkend="ntsec"></xref>.  As
of version 1.5.13, the Cygwin developers are not aware of any feature in
the Cygwin DLL that would allow users to gain privileges or to access
objects to which they have no rights under Windows.  However there is no
guarantee that Cygwin is as secure as the Windows it runs on. Cygwin
processes share some variables and are thus easier targets of denial of
service type of attacks.
</para>

</sect2>

<sect2 id="ov-hi-files"><title>File Access</title> <para>Cygwin supports
both POSIX- and Win32-style paths, using either forward or back slashes as the
directory delimiter.  Paths coming into the DLL are translated from POSIX to
native NT as needed.  From the application perspective, the file system is
a POSIX-compliant one.  The implementation details are safely hidden in the
Cygwin DLL.  UNC pathnames (starting with two slashes) are supported for
network paths.</para>

<para>Since version 1.7.0, the layout of this POSIX view of the Windows file
system space is stored in the <filename>/etc/fstab</filename> file.  Actually,
there is a system-wide <filename>/etc/fstab</filename> file as well as a
user-specific fstab file <filename>/etc/fstab.d/${USER}</filename>.</para>

<para>At startup the DLL has to find out where it can find the
<filename>/etc/fstab</filename> file.  The mechanism used for this is simple.
First it retrieves it's own path, for instance
<filename>C:\Cygwin\bin\cygwin1.dll</filename>.  From there it deduces
that the root path is <filename>C:\Cygwin</filename>.  So it looks for the
<filename>fstab</filename> file in <filename>C:\Cygwin\etc\fstab</filename>. 
The layout of this file is very similar to the layout of the
<filename>fstab</filename> file on Linux.  Just instead of block devices,
the mount points point to Win32 paths.  An installation with
<command>setup.exe</command> installs a <filename>fstab</filename> file by
default, which can easily be changed using the editor of your choice.</para>

<para>The <filename>fstab</filename> file allows mounting arbitrary Win32
paths into the POSIX file system space.  A special case is the so-called
cygdrive prefix.
It's the path under which every available drive in the system is mounted
under its drive letter.  The default value is <filename>/cygdrive</filename>,
so you can access the drives as <filename>/cygdrive/c</filename>,
<filename>/cygdrive/d</filename>, etc...  The cygdrive prefix can be set to
some other value (<filename>/mnt</filename> for instance) in the
<filename>fstab</filename> file(s).</para>

<para>The library exports several Cygwin-specific functions that can be used
by external programs to convert a path or path list from Win32 to POSIX or vice
versa.  Shell scripts and Makefiles cannot call these functions directly.
Instead, they can do the same path translations by executing the
<command>cygpath</command> utility program that we provide with Cygwin.</para>

<para>Win32 applications handle filenames in a case preserving, but case
insensitive manner.  Cygwin supports case sensitivity on file systems
supporting that.  Since Windows XP, the OS only supports case
sensitivity when a specific registry value is changed.  Therefore, case
sensitivity is not usually the default.</para>

<para>Symbolic links are not present and supported on Windows up to and
including Windows Server 2003 R2.  Native symlinks are available starting
with Windows Vista.  Due to their strange implementation, however,
they are not useful in a POSIX emulation layer.  Cygwin recognizes
native symlinks, but does not create them.</para>

<para>Symbolic links are potentially created in two different ways.
The file style symlinks are files containing a magic cookie followed by
the path to which the link points.  They are marked with the System DOS
attribute so that only files with that attribute have to be read to
determine whether or not the file is a symbolic link.  The shortcut style
symlinks are Windows shortcut files with a special header and the
Readonly DOS attribute set.  The advantage of file symlinks is speed,
the advantage of shortcut symlinks is the fact that they can be utilized
by non-Cygwin Win32 tools as well.</para>

<para>Starting with Cygwin 1.7, symbolic links are using UTF-16 to encode
the filename of the target file, to better support internationalization.
Symlinks created by older Cygwin releases can be read just fine.  However,
you could run into problems with them if you're now using another character
set than the one you used when creating these symlinks
(see <xref linkend="setup-locale-problems"></xref>.  Please note that this
new UTF-16 style of symlinks is not compatible with older Cygwin release,
which can't read the target filename correctly.</para>

<para>Hard links are fully supported on NTFS and NFS file systems.  On FAT
and other file systems which don't support hardlinks, the call returns with
an error, just like on other POSIX systems.</para>

<para>On file systems which don't support unique persistent file IDs (FAT,
older Samba shares) the inode number for a file is calculated by hashing its
full Win32 path.  The inode number generated by the stat call always matches
the one returned in <literal>d_ino</literal> of the <literal>dirent</literal>
structure.  It is worth noting that the number produced by this method is not
guaranteed to be unique.  However, we have not found this to be a significant
problem because of the low probability of generating a duplicate inode number.
</para>

<para>Cygwin 1.7 and later supports Extended Attributes (EAs) via the
linux-specific function calls <function>getxattr</function>,
<function>setxattr</function>, <function>listxattr</function>, and
<function>removexattr</function>.  All EAs on Samba or NTFS are treated as
user EAs, so, if the name of an EA is "foo" from the Windows perspective,
it's transformed into "user.foo" within Cygwin.  This allows Linux-compatible
EA operations and keeps tools like <command>attr</command>, or
<command>setfattr</command> happy.
</para>

<para><function>chroot</function> is supported since Cygwin 1.1.3.
However, chroot is not a concept known by Windows.  This implies some serious
restrictions.  First of all, the <function>chroot</function> call isn't a
privileged call.  Any user may call it.  Second, the chroot environment
isn't safe against native windows processes.  Given that, chroot in Cygwin
is only a hack which pretends security where there is none.  For that reason
the usage of chroot is discouraged.
</para>
</sect2>

<sect2 id="ov-hi-textvsbinary"><title>Text Mode vs. Binary Mode</title>
<para>It is often important that files created by native Windows
applications be interoperable with Cygwin applications.  For example, a
file created by a native Windows text editor should be readable by a
Cygwin application, and vice versa.</para>

<para>Unfortunately, UNIX and Win32 have different end-of-line
conventions in text files.  A UNIX text file will have a single newline
character (LF) whereas a Win32 text file will instead use a two
character sequence (CR+LF).  Consequently, the two character sequence
must be translated on the fly by Cygwin into a single character newline
when reading in text mode.</para>

<para>This solution addresses the newline interoperability concern at
the expense of violating the POSIX requirement that text and binary mode
be identical.  Consequently, processes that attempt to lseek through
text files can no longer rely on the number of bytes read to be an
accurate indicator of position within the file.  For this reason, Cygwin
allows you to choose the mode in which a file is read in several ways.</para>
</sect2>

<sect2 id="ov-hi-ansiclib"><title>ANSI C Library</title>
<para>We chose to include Red Hat's own existing ANSI C library
"newlib" as part of the library, rather than write all of the lib C
and math calls from scratch.  Newlib is a BSD-derived ANSI C library,
previously only used by cross-compilers for embedded systems
development.  Other functions, which are not supported by newlib have
been added to the Cygwin sources using BSD implementations as much as
possible.</para>

<para>The reuse of existing free implementations of such things
as the glob, regexp, and getopt libraries saved us considerable
effort.  In addition, Cygwin uses Doug Lea's free malloc
implementation that successfully balances speed and compactness.  The
library accesses the malloc calls via an exported function pointer.
This makes it possible for a Cygwin process to provide its own
malloc if it so desires.</para>
</sect2>

<sect2 id="ov-hi-process"><title>Process Creation</title>
<para>The <function>fork</function> call in Cygwin is particularly interesting
because it does not map well on top of the Win32 API.  This makes it very
difficult to implement correctly.  Currently, the Cygwin fork is a
non-copy-on-write implementation similar to what was present in early
flavors of UNIX.</para>

<para>The first thing that happens when a parent process
forks a child process is that the parent initializes a space in the
Cygwin process table for the child.  It then creates a suspended
child process using the Win32 CreateProcess call.  Next, the parent
process calls setjmp to save its own context and sets a pointer to
this in a Cygwin shared memory area (shared among all Cygwin
tasks).  It then fills in the child's .data and .bss sections by
copying from its own address space into the suspended child's address
space.  After the child's address space is initialized, the child is
run while the parent waits on a mutex.  The child discovers it has
been forked and longjumps using the saved jump buffer.  The child then
sets the mutex the parent is waiting on and blocks on another mutex.
This is the signal for the parent to copy its stack and heap into the
child, after which it releases the mutex the child is waiting on and
returns from the fork call.  Finally, the child wakes from blocking on
the last mutex, recreates any memory-mapped areas passed to it via the
shared area, and returns from fork itself.</para>

<para>While we have some
ideas as to how to speed up our fork implementation by reducing the
number of context switches between the parent and child process, fork
will almost certainly always be inefficient under Win32.  Fortunately,
in most circumstances the spawn family of calls provided by Cygwin
can be substituted for a fork/exec pair with only a little effort.
These calls map cleanly on top of the Win32 API.  As a result, they
are much more efficient.  Changing the compiler's driver program to
call spawn instead of fork was a trivial change and increased
compilation speeds by twenty to thirty percent in our
tests.</para>

<para>However, spawn and exec present their own set of
difficulties.  Because there is no way to do an actual exec under
Win32, Cygwin has to invent its own Process IDs (PIDs).  As a
result, when a process performs multiple exec calls, there will be
multiple Windows PIDs associated with a single Cygwin PID.  In some
cases, stubs of each of these Win32 processes may linger, waiting for
their exec'd Cygwin process to exit.</para>
</sect2>

<sect3 id='ov-hi-process-problems'>
<title>Problems with process creation</title>

<para>The semantics of <literal>fork</literal> require that a forked
child process have <emphasis>exactly</emphasis> the same address
space layout as its parent. However, Windows provides no native
support for cloning address space between processes and several
features actively undermine a reliable <literal>fork</literal>
implementation. Three issues are especially prevalent:</para>

<para><itemizedlist>
<listitem>DLL base address collisions. Unlike *nix shared
libraries, which use "position-independent code", Windows shared
libraries assume a fixed base address. Whenever the hard-wired
address ranges of two DLLs collide (which occurs quite often), the
Windows loader must "rebase" one of them to a different
address. However, it may not resolve collisions consistently, and
may rebase a different dll and/or move it to a different address
every time. Cygwin can usually compensate for this effect when it
involves libraries opened dynamically, but collisions among
statically-linked dlls (dependencies known at compile time) are
resolved before <literal>cygwin1.dll</literal> initializes and
cannot be fixed afterward. This problem can only be solved by
removing the base address conflicts which cause the problem,
usually using the <literal>rebaseall</literal> tool.</listitem>

<listitem>Address space layout randomization (ASLR). Starting with
Vista, Windows implements ASLR, which means that thread stacks,
heap, memory-mapped files, and statically-linked dlls are placed
at different (random) locations in each process. This behaviour
interferes with a proper <literal>fork</literal>, and if an
unmovable object (process heap or system dll) ends up at the wrong
location, Cygwin can do nothing to compensate (though it will
retry a few times automatically).</listitem>

<listitem>DLL injection by
<ulink url="http://cygwin.com/faq/faq.using.html#faq.using.bloda">
BLODA</ulink>. Badly-behaved applications which
inject dlls into other processes often manage to clobber important
sections of the child's address space, leading to base address
collisions which rebasing cannot fix. The only way to resolve this
problem is to remove (usually uninstall) the offending app.  See
<xref linkend="cygwinenv-implemented-options"></xref> for the
<literal>detect_bloda</literal> option, which may be able to identify the
BLODA.</listitem></itemizedlist></para>

<para>In summary, current Windows implementations make it
impossible to implement a perfectly reliable fork, and occasional
fork failures are inevitable.
</para>

</sect3>

<sect2 id="ov-hi-signals"><title>Signals</title>
<para>When
a Cygwin process starts, the library starts a secondary thread for
use in signal handling.  This thread waits for Windows events used to
pass signals to the process.  When a process notices it has a signal,
it scans its signal bitmask and handles the signal in the appropriate
fashion.</para>

<para>Several complications in the implementation arise from the
fact that the signal handler operates in the same address space as the
executing program.  The immediate consequence is that Cygwin system
functions are interruptible unless special care is taken to avoid
this.   We go to some lengths to prevent the sig_send function that
sends signals from being interrupted.  In the case of a process
sending a signal to another process, we place a mutex around sig_send
such that sig_send will not be interrupted until it has completely
finished sending the signal.</para>

<para>In the case of a process sending
itself a signal, we use a separate semaphore/event pair instead of the
mutex.  sig_send starts by resetting the event and incrementing the
semaphore that flags the signal handler to process the signal.  After
the signal is processed, the signal handler signals the event that it
is done.  This process keeps intraprocess signals synchronous, as
required by POSIX.</para>

<para>Most standard UNIX signals are provided.  Job
control works as expected in shells that support
it.</para>
</sect2>

<sect2 id="ov-hi-sockets"><title>Sockets</title>
<para>Socket-related calls in Cygwin basically call the functions by the
same name in Winsock, Microsoft's implementation of Berkeley sockets, but
with lots of tweaks.  All sockets are non-blocking under the hood to allow
to interrupt blocking calls by POSIX signals.  Additional bookkeeping is
necessary to implement correct socket sharing POSIX semantics and especially
for the select call.  Some socket-related functions are not implemented at
all in Winsock, as, for example, socketpair.  Starting with Windows Vista,
Microsoft removed the legacy calls <function>rcmd(3)</function>,
<function>rexec(3)</function> and <function>rresvport(3)</function>.
Recent versions of Cygwin now implement all these calls internally.</para>

<para>An especially troublesome feature of Winsock is that it must be
initialized before the first socket function is called.  As a result, Cygwin
has to perform this initialization on the fly, as soon as the first
socket-related function is called by the application.  In order to support
sockets across fork calls, child processes initialize Winsock if any
inherited file descriptor is a socket.</para>

<para>AF_UNIX (AF_LOCAL) sockets are not available in Winsock.  They are
implemented in Cygwin by using local AF_INET sockets instead.  This is
completely transparent to the application.  Cygwin's implementation also
supports the getpeereid BSD extension.  However, Cygwin does not yet support
descriptor passing.</para>

<para>IPv6 is supported beginning with Cygwin release 1.7.0.  This
support is dependent, however, on the availability of the Windows IPv6
stack.  The IPv6 stack was "experimental", i.e. not feature complete in
Windows 2003 and earlier.  Full IPv6 support became available starting
with Windows Vista and Windows Server 2008.  Cygwin does not depend on
the underlying OS for the (newly implemented) <function>getaddrinfo</function>
and <function>getnameinfo</function> functions.  Cygwin 1.7.0 adds
replacement functions which implement the full functionality for IPv4.</para>

</sect2>

<sect2 id="ov-hi-select"><title>Select</title>
<para>The UNIX <function>select</function> function is another
call that does not map cleanly on top of the Win32 API.  Much to our
dismay, we discovered that the Win32 select in Winsock only worked on
socket handles.  Our implementation allows select to function normally
when given different types of file descriptors (sockets, pipes,
handles, and a custom /dev/windows Windows messages
pseudo-device).</para>

<para>Upon entry into the select function, the first
operation is to sort the file descriptors into the different types.
There are then two cases to consider.  The simple case is when at
least one file descriptor is a type that is always known to be ready
(such as a disk file).  In that case, select returns immediately as
soon as it has polled each of the other types to see if they are
ready.  The more complex case involves waiting for socket or pipe file
descriptors to be ready.  This is accomplished by the main thread
suspending itself, after starting one thread for each type of file
descriptor present.  Each thread polls the file descriptors of its
respective type with the appropriate Win32 API call.  As soon as a
thread identifies a ready descriptor, that thread signals the main
thread to wake up.  This case is now the same as the first one since
we know at least one descriptor is ready.  So select returns, after
polling all of the file descriptors one last time.</para>
</sect2>
</sect1>


--------------020602000108030501060005
Content-Type: text/xml;
 name="ov-ex-unix.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ov-ex-unix.xml"
Content-length: 2411

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<sect1 id="ov-ex-unix">
<title>Quick Start Guide for those more experienced with UNIX</title>
<para>
If you are an experienced UNIX user who misses a powerful command-line
environment, you will enjoy Cygwin.
Developers coming from a UNIX background will find a set of utilities
they are already comfortable using, including a working UNIX shell.  The
compiler tools are the standard GNU compilers most people will have previously
used under UNIX, only ported to the Windows host.  Programmers wishing to port
UNIX software to Windows NT will find that the Cygwin library provides
an easy way to port many UNIX packages, with only minimal source code
changes.
</para>
<para>
Note that there are some workarounds that cause Cygwin to behave differently
than most UNIX-like operating systems; these are described in more detail in 
<xref linkend="using-effectively"></xref>.
</para>
<para>
Use the graphical command <command>setup.exe</command> any time you want
to update or install a Cygwin package.  This program must be run
manually every time you want to check for updated packages since Cygwin
does not currently include a mechanism for automatically detecting
package updates.
</para>
<para>
By default, <command>setup.exe</command> only installs a minimal subset of
packages.  Add any other packages by clicking on the <literal>+</literal>
next to the Category name and selecting the package from the displayed
list.  You may search for specfic tools by using the
<ulink url="http://cygwin.com/packages/">Setup Package Search</ulink>
at the Cygwin web site.
</para>
<para>
Another option is to install everything by clicking on the
<literal>Default</literal> field next to the <literal>All</literal>
category. However, be advised that this will download and install
several hundreds of megabytes of software to your computer. The best
plan is probably to click on individual categories and install either
entire categories or packages from the categories themselves.
After installation, you can find Cygwin-specific documentation in
the <literal>/usr/share/doc/Cygwin/</literal> directory.
</para>
<para>
For more information about what each option in
<command>setup.exe</command> means, see <xref
linkend="internet-setup"></xref>.
</para>

</sect1>

--------------020602000108030501060005
Content-Type: text/xml;
 name="ov-ex-win.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ov-ex-win.xml"
Content-length: 2331

<?xml version="1.0" encoding='UTF-8'?>
<!DOCTYPE sect1 PUBLIC "-//OASIS//DTD DocBook V4.5//EN"
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd">

<sect1 id="ov-ex-win">
<title>Quick Start Guide for those more experienced with Windows</title>
<para>
If you are new to the world of UNIX, you may find it difficult to
understand at first. This guide is not meant to be comprehensive,
so we recommend that you use the many available Internet resources
to become acquainted with UNIX basics (search for "UNIX basics" or
"UNIX tutorial"). 
</para>
<para>
To install a basic Cygwin environment, run the
<command>setup.exe</command> program and click <literal>Next</literal>
at each page.  The default settings are correct for most users. If you
want to know more about what each option means, see 
<xref linkend="internet-setup"></xref>. Use <command>setup.exe</command>
any time you want to update or install a Cygwin package.  If you are
installing Cygwin for a specific purpose, use it to install the tools
that you need. For example, if you want to compile C++ programs, you 
need the <systemitem>gcc-g++</systemitem> package and probably a text
editor like <systemitem>nano</systemitem>.  When running
<command>setup.exe</command>, clicking on categories and packages in the
package installation screen will provide you with the ability to control
what is installed or updated. 
</para>
<para>
Another option is to install everything by clicking on the
<literal>Default</literal> field next to the <literal>All</literal>
category. However, be advised that this will download and install
several hundreds of megabytes of software to your computer. The best
plan is probably to click on individual categories and install either
entire categories or packages from the categories themselves.
After installation, you can find Cygwin-specific documentation in
the <literal>/usr/share/doc/Cygwin/</literal> directory.
</para>
<para>
Developers coming from a Windows background will be able to write 
console or GUI executables that rely on the Microsoft Win32 API instead
of Cygwin using the mingw32 or mingw64 cross-compiler toolchains.  The
<command>-shared</command> option to GCC allows to write Windows Dynamically
Linked Libraries (DLLs).  The resource compiler <command>windres</command>
is also provided.
</para>
</sect1>

--------------020602000108030501060005--
