Return-Path: <cygwin-patches-return-3839-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27203 invoked by alias); 30 Apr 2003 01:37:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27190 invoked from network); 30 Apr 2003 01:37:53 -0000
Date: Wed, 30 Apr 2003 01:37:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: Robert Collins <rbcollins@cygwin.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: hostid patch
Message-ID: <20030430013844.GA21521@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Robert Collins <rbcollins@cygwin.com>,
	cygwin-patches@cygwin.com
References: <LPEHIHGCJOAIPFLADJAHMEPHDIAA.chris@atomice.net> <LPEHIHGCJOAIPFLADJAHMEIFDJAA.chris@atomice.net> <20030430010018.GA21292@redhat.com> <1051664682.3113.16.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <1051664682.3113.16.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00066.txt.bz2


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 923

On Wed, Apr 30, 2003 at 11:04:43AM +1000, Robert Collins wrote:
>On Wed, 2003-04-30 at 11:00, Christopher Faylor wrote:
>
>
>> 
>> Three runs, two different results:
>
>I count three runs, three result there.

Hmm.  You're right.  I thought the last two hostids were the same but
they obviously weren't.

>Interestingly, the PSN was different on every case..

Running under strace the PSN stayed the same for a long time.  I thought
it was going to be one of those "runs fine under strace" scenarios.

>Is this a real box, or VMWare / bochs etc?

It's an FreeBSD box running VMWare, running linux.  I'm running cygwin under
wine on linux.  I can't see how that could be a problem. :-)

>How many cpus are in it?

cygcheck attached.  Hmm.  Cygcheck doesn't say how many CPUs, does it?

/proc/cpuinfo attached, too.

Two CPUs.  Different steppings for each.  The Dell BIOS kindly informs
me of that fact on each reboot.

cgf

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuinfo.out"
Content-length: 768

processor       : 0
vendor_id       : GenuineIntel
type            : primary processor
cpu family      : 6
model           : 8
model name      : unknown
stepping        : 6
brand id        : 2
cpu count       : 0
apic id         : 0
cpu MHz         : 731
fpu             : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 psn mmx fxsr sse
processor       : 1
vendor_id       : GenuineIntel
type            : primary processor
cpu family      : 6
model           : 8
model name      : unknown
stepping        : 3
brand id        : 2
cpu count       : 0
apic id         : 0
cpu MHz         : 731
fpu             : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 psn mmx fxsr sse

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cygcheck.out"
Content-length: 21659


Cygwin Win95/NT Configuration Diagnostics
Current System Time: Tue Apr 29 21:33:10 2003

Windows XP Professional Ver 5.1 Build 2600 Service Pack 1

Path:	f:\cygwin\bin
	L:\WINXP\system32
	L:\WINXP
	L:\WINXP\system32\WBEM
	F:\msdev\Tools\WinNT
	F:\msdev\MSDev98\Bin
	F:\msdev\Tools
	F:\Microsoft Visual Studio\VC98\bin

f:\cygwin\bin\id.exe output (nontsec)
UID: 1003(cgf)  GID: 513(None)
548(bar)        5491(foo)       513(None)

f:\cygwin\bin\id.exe output (ntsec)
UID: 1003(cgf)             GID: 513(None)
513(None)                  544(Administrators)
555(Remote Desktop Users)  545(Users)
1006(mail)

SysDir: L:\WINXP\System32
WinDir: L:\WINXP

cygwin = `tty'
HOME = `\\trixie\home\cgf'
MAKE_MODE = `unix'
Path = `f:\cygwin\bin;L:\WINXP\system32;L:\WINXP;L:\WINXP\system32\WBEM;F:\msdev\Tools\WinNT;F:\msdev\MSDev98\Bin;F:\msdev\Tools;F:\Microsoft Visual Studio\VC98\bin'

HKEY_CURRENT_USER\Software\Cygnus Solutions
HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin
HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin\mounts v2
HKEY_CURRENT_USER\Software\Cygnus Solutions\Cygwin\Program Options
  (default) = `error_start=d:\gdbtest\gdb.exe'
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\WorkgroupCrawler\Shares\TRIXIE/cygnus
  (default) = `cygnus on Samba 2.2.4 (Trixie)'
  DateLastVisited = (unsupported type)
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2
  (default) = `/cygdrive'
  cygdrive flags = 0x00000022
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/
  (default) = `f:\cygwin'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/bin
  (default) = `f:\cygwin\bin'
  flags = 0x0000004a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/bin/cygcheck
  (default) = `f:\cygwin\bin\cygcheck.exe'
  flags = 0x0000001a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/bin/cygcheck.exe
  (default) = `f:\cygwin\bin\cygcheck.exe'
  flags = 0x0000001a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/bin/strace
  (default) = `f:\cygwin\bin\strace.exe'
  flags = 0x00000018
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/bin/strace.exe
  (default) = `f:\cygwin\bin\strace.exe'
  flags = 0x00000018
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/build
  (default) = `\\trixie\cygnus\bbc\build'
  flags = 0x0000010a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/ctmp
  (default) = `c:\tmp'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/cygbuild
  (default) = `j:\build'
  flags = 0x00000108
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/cygnus
  (default) = `\\trixie\cygnus'
  flags = 0x0000010a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/cygnus/src/uberbaum/dejagnu/runtest
  (default) = `\\trixie\cygnus\src\uberbaum\dejagnu\runtest'
  flags = 0x0000004a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/cygnus/src/uberbaum/winsup/dejagnu/runtest
  (default) = `\\trixie\cygnus\src\uberbaum\winsup\dejagnu\runtest'
  flags = 0x0000004a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/cygwin-src
  (default) = `j:\cygwin-src'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/etc/group
  (default) = `f:\cygwin\etc\group.xp'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/etc/passwd
  (default) = `f:\cygwin\etc\passwd.xp'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/gnupro-02r1
  (default) = `\\trixie\cygnus\gnupro-02rq'
  flags = 0x0000010a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/home
  (default) = `\\trixie\home'
  flags = 0x0000010a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/home/cgf/.ssh
  (default) = `d:\home\cgf\.ssh'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/netrel
  (default) = `\\trixie\cygnus\netrel'
  flags = 0x0000010a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/source
  (default) = `\\trixie\source'
  flags = 0x0000010a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/source/common/bin
  (default) = `\\trixie\source\common\bin'
  flags = 0x0000004a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/tmp
  (default) = `j:\tmp'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/usr/bin
  (default) = `f:\cygwin\bin'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/usr/lib
  (default) = `f:\cygwin/lib'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/usr/sbin
  (default) = `f:\cygwin\usr\sbin'
  flags = 0x0000004a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/usr/src
  (default) = `e:\src'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/usr/X11R6/bin
  (default) = `f:\cygwin\usr\X11R6\bin'
  flags = 0x0000004a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/usr/X11R6/lib/X11/fonts
  (default) = `f:\cygwin\usr\X11R6\lib\X11\fonts'
  flags = 0x0000000a
HKEY_LOCAL_MACHINE\SOFTWARE\Cygnus Solutions\Cygwin\Program Options

a:  fd           N/A    N/A                    
c:  hd  FAT     1082Mb  75% CP    UN           WIN95
d:  hd  NTFS    8675Mb  11% CP CS UN PA FC     NT 4.0
e:  hd  FAT32   2043Mb  30% CP    UN           
f:  hd  FAT32   2286Mb  87% CP    UN           
g:  cd  CDFS     455Mb 100%    CS UN           TURBOTAX02
h:  hd  FAT32   1362Mb  82% CP    UN           WINDOWS 98
i:  hd  NTFS    2753Mb  58% CP CS UN PA FC     W2K Boot
j:  hd  NTFS    2753Mb  61% CP CS UN PA FC     W2K Copy
l:  hd  NTFS    9750Mb  88% CP CS UN PA FC     
m:  net NTFS   68682Mb  86% CP CS    PA        cgf

f:\cygwin                                            /                                            system  binmode
f:\cygwin\bin                                        /bin                                         system  binmode,cygexec
f:\cygwin\bin\cygcheck.exe                           /bin/cygcheck                                system  binmode,exec
f:\cygwin\bin\cygcheck.exe                           /bin/cygcheck.exe                            system  binmode,exec
f:\cygwin\bin\strace.exe                             /bin/strace                                  system  textmode,exec
f:\cygwin\bin\strace.exe                             /bin/strace.exe                              system  textmode,exec
\\trixie\cygnus\bbc\build                            /build                                       system  binmode
c:\tmp                                               /ctmp                                        system  binmode
j:\build                                             /cygbuild                                    system  textmode
\\trixie\cygnus                                      /cygnus                                      system  binmode
\\trixie\cygnus\src\uberbaum\dejagnu\runtest         /cygnus/src/uberbaum/dejagnu/runtest         system  binmode,cygexec
\\trixie\cygnus\src\uberbaum\winsup\dejagnu\runtest  /cygnus/src/uberbaum/winsup/dejagnu/runtest  system  binmode,cygexec
j:\cygwin-src                                        /cygwin-src                                  system  binmode
f:\cygwin\etc\group.xp                               /etc/group                                   system  binmode
f:\cygwin\etc\passwd.xp                              /etc/passwd                                  system  binmode
\\trixie\cygnus\gnupro-02rq                          /gnupro-02r1                                 system  binmode
\\trixie\home                                        /home                                        system  binmode
d:\home\cgf\.ssh                                     /home/cgf/.ssh                               system  binmode
\\trixie\cygnus\netrel                               /netrel                                      system  binmode
\\trixie\source                                      /source                                      system  binmode
\\trixie\source\common\bin                           /source/common/bin                           system  binmode,cygexec
j:\tmp                                               /tmp                                         system  binmode
f:\cygwin\bin                                        /usr/bin                                     system  binmode
f:\cygwin/lib                                        /usr/lib                                     system  binmode
f:\cygwin\usr\sbin                                   /usr/sbin                                    system  binmode,cygexec
e:\src                                               /usr/src                                     system  binmode
f:\cygwin\usr\X11R6\bin                              /usr/X11R6/bin                               system  binmode,cygexec
f:\cygwin\usr\X11R6\lib\X11\fonts                    /usr/X11R6/lib/X11/fonts                     system  binmode
.                                                    /cygdrive                                    system  binmode,cygdrive

Found: f:\cygwin\bin\awk.exe
Found: f:\cygwin\bin\bash.exe
Found: f:\cygwin\bin\cat.exe
Found: f:\cygwin\bin\cp.exe
Found: f:\cygwin\bin\cpp.exe
Found: f:\cygwin\bin\find.exe
Found: f:\cygwin\bin\gcc.exe
Found: f:\cygwin\bin\gdb.exe
Found: f:\cygwin\bin\grep.exe
Found: f:\cygwin\bin\ld.exe
Found: f:\cygwin\bin\ls.exe
Found: f:\cygwin\bin\make.exe
Found: f:\cygwin\bin\mv.exe
Found: f:\cygwin\bin\rm.exe
Found: f:\cygwin\bin\sed.exe
Found: f:\cygwin\bin\sh.exe
Found: f:\cygwin\bin\tar.exe

   45k 2001/04/25 f:\cygwin\bin\cygform5.dll
   26k 2001/04/25 f:\cygwin\bin\cygmenu5.dll
  156k 2001/04/25 f:\cygwin\bin\cygncurses++5.dll
  226k 2001/04/25 f:\cygwin\bin\cygncurses5.dll
   15k 2001/04/25 f:\cygwin\bin\cygpanel5.dll
   21k 2001/06/20 f:\cygwin\bin\cygintl.dll
   50k 2002/03/12 f:\cygwin\bin\cygz.dll
   22k 2001/12/13 f:\cygwin\bin\cygintl-1.dll
  119k 2002/02/09 f:\cygwin\bin\cygjpeg6b.dll
   19k 2003/03/22 f:\cygwin\bin\cyggdbm.dll
  568k 2000/07/29 f:\cygwin\bin\cygwin1-1.1.3.dll
  170k 2002/01/21 f:\cygwin\bin\cygpng2.dll
  575k 2000/07/29 f:\cygwin\bin\cygwin1-1.1.2.dll
   47k 2003/03/09 f:\cygwin\bin\cygjbig1.dll
   58k 2002/05/07 f:\cygwin\bin\cygbz2-1.dll
  136k 2002/10/17 f:\cygwin\bin\cygexpat-0.dll
   63k 2003/04/11 f:\cygwin\bin\cygpcre.dll
   35k 2002/01/09 f:\cygwin\bin\cygform6.dll
   20k 2002/01/09 f:\cygwin\bin\cygmenu6.dll
  175k 2002/01/09 f:\cygwin\bin\cygncurses++6.dll
  202k 2002/01/09 f:\cygwin\bin\cygncurses6.dll
   12k 2002/01/09 f:\cygwin\bin\cygpanel6.dll
  551k 2003/04/02 f:\cygwin\bin\cygcurl-2.dll
  633k 2002/07/22 f:\cygwin\bin\cygxml2-2.dll
  152k 2002/03/17 f:\cygwin\bin\cygxslt-1.dll
   50k 2002/03/17 f:\cygwin\bin\cygexslt-0.dll
   15k 2002/03/17 f:\cygwin\bin\cygxsltbreakpoint-1.dll
   41k 2002/01/20 f:\cygwin\bin\cygXpm-noX4.dll
   46k 2002/01/20 f:\cygwin\bin\cygXpm-X4.dll
   28k 2002/09/20 f:\cygwin\bin\cygintl-2.dll
   20k 2002/10/10 f:\cygwin\bin\cyghistory5.dll
  127k 2002/10/10 f:\cygwin\bin\cygreadline5.dll
   25k 2002/07/14 f:\cygwin\bin\cygungif-4.dll
   22k 2002/06/09 f:\cygwin\bin\cygpopt-0.dll
   61k 2003/04/11 f:\cygwin\bin\cygpcreposix.dll
  281k 2003/02/24 f:\cygwin\bin\cygtiff3.dll
   66k 2001/11/20 f:\cygwin\bin\cygregex.dll
   32k 2003/02/17 f:\cygwin\bin\cygltdl-3.dll
  168k 2003/02/23 f:\cygwin\bin\cygpng10.dll
  173k 2003/02/23 f:\cygwin\bin\cygpng12.dll
   12k 2003/02/17 f:\cygwin\bin\cygioperm-0.dll
  848k 2003/04/11 f:\cygwin\bin\cygcrypto-0.9.7.dll
  176k 2003/04/11 f:\cygwin\bin\cygssl-0.9.7.dll
   54k 2002/01/27 f:\cygwin\bin\cygbz21.0.dll
  645k 2003/04/11 f:\cygwin\bin\cygcrypto.dll
  165k 2003/04/11 f:\cygwin\bin\cygssl.dll
    6k 2002/06/24 f:\cygwin\bin\cygcharset-1.dll
   61k 2003/03/05 f:\cygwin\bin\cygkpathsea-3.dll
  490k 2002/09/21 f:\cygwin\bin\cygguile-12.dll
  488k 2002/07/18 f:\cygwin\bin\cygguile-14.dll
  326k 2002/06/26 f:\cygwin\bin\cygdb2.dll
  380k 2002/07/24 f:\cygwin\bin\cygdb-3.1.dll
  487k 2002/07/24 f:\cygwin\bin\cygdb_cxx-3.1.dll
   24k 2002/07/18 f:\cygwin\bin\cygguile-srfi-srfi-4-1.dll
   14k 2002/07/18 f:\cygwin\bin\cygguilereadline-14.dll
   63k 2002/09/21 f:\cygwin\bin\cygguile-srfi-srfi-13-14-v-1-1.dll
   24k 2002/09/21 f:\cygwin\bin\cygguile-srfi-srfi-4-v-1-1.dll
  929k 2002/06/24 f:\cygwin\bin\cygiconv-2.dll
   14k 2002/09/21 f:\cygwin\bin\cygguilereadline-v-12-12.dll
   63k 2002/07/18 f:\cygwin\bin\cygguile-srfi-srfi-13-14-1.dll
   28k 2003/03/22 f:\cygwin\bin\cyggdbm-3.dll
   15k 2003/03/22 f:\cygwin\bin\cyggdbm_compat-3.dll
   76k 2003/03/09 f:\cygwin\bin\cygform7.dll
   48k 2003/03/09 f:\cygwin\bin\cygmenu7.dll
  284k 2003/03/09 f:\cygwin\bin\cygncurses7.dll
   31k 2003/03/09 f:\cygwin\bin\cygpanel7.dll
 1005k 2003/03/30 f:\cygwin\bin\cygperl5_8_0.dll
 9021k 2003/04/27 f:\cygwin\bin\cygwin1.dll
    Cygwin DLL version info:
        DLL version: 1.5.0
        DLL epoch: 19
        DLL bad signal mask: 19005
        DLL old termios: 5
        DLL malloc env: 28
        API major: 0
        API minor: 84
        Shared data: 3
        DLL identifier: cygwin1
        Mount registry: 2
        Cygnus registry name: Cygnus Solutions
        Cygwin registry name: Cygwin
        Program options name: Program Options
        Cygwin mount registry name: mounts v2
        Cygdrive flags: cygdrive flags
        Cygdrive prefix: cygdrive prefix
        Cygdrive default prefix: 
        Build date: Sat Apr 26 23:23:01 EDT 2003
        Shared id: cygwin1S3-2003-04-26 23:23


Cygwin Package Information
Package                 Version
_update-info-dir        00160-1
agetty                  2.1-1
ash                     20020731-1
astyle                  1.15.3-3
autoconf                2.54-1
autoconf-devel          2.57-1
autoconf-stable         2.13-4
automake                1.7.1-1
automake-devel          1.7.3-1
automake-stable         1.4p5-5
base-files              1.3-1
base-passwd             1.1-1
bash                    2.05b-9
bc                      1.06-1
binutils                20030307-1
bison                   20030307-1
byacc                   1.9-1
bzip2                   1.0.2-2
ccache                  1.9-1
cgoban                  1.9.12-1
chkconfig               1.2.24h-1
clear                   1.0-1
compface                1.4-5
cpio                    2.5-1
cron                    3.0.1-7
crypt                   1.0-1
ctags                   5.2-1
curl                    7.10.4-1
curl-devel              7.10.4-1
cvs                     1.11.0-1
cygrunsrv               0.95-1
cygutils                1.1.3-1
cygwin                  1.3.22-1
cygwin-doc              1.3-3
db2                     2.7.7-4
db3.1                   3.1.17-2
dejagnu                 20021217-2
diff                    1.0-1
diffutils               2.8.1-1
dpkg                    1.10.4-2
ed                      0.2-1
ELFIO                   1.0.0-1
emacs                   21.2-12
emacs-el                21.2-12
emacs-X11               21.2-12
enscript                1.6.3-3
exim                    4.14-1
expat                   1.95.5-1
expect                  20030128-1
fetchmail               6.2.2-1
figlet                  2.2-1
file                    3.39-1
fileutils               4.1-1
findutils               4.1.7-4
flex                    2.5.4-2
fortune                 1.8-2
fvwm                    2.4.7-2
gawk                    3.1.2-2
gcc                     3.2-3
gcc-mingw               20020817-5
gcc2                    2.95.3-10
gdb                     20030303-1
gdbm                    1.8.0-5
gettext                 0.11.5-1
gettext-devel           0.11.5-1
ghostscript             7.05-2
ghostscript-base        7.05-2
ghostscript-x11         7.05-2
gnugo                   3.2-1
gnupg                   1.2.1-1
gperf                   2.7.2-1
grep                    2.5-1
groff                   1.18.1-2
gsl                     1.3-1
gzip                    1.3.3-4
indent                  2.2.8-1
inetutils               1.3.2-20
initscripts             0.9-1
ioperm                  0.4-1
irc                     20010101-1
jbigkit                 1.4-1
jpeg                    6b-7
keychain                1.9-1
less                    378-1
libbz2_0                1.0.2-1
libbz2_1                1.0.2-2
libcharset1             1.8-2
libdb2                  2.7.7-4
libdb2-devel            2.7.7-4
libdb3.1                3.1.17-2
libdb3.1-devel          3.1.17-2
libgdbm                 1.8.0-5
libgdbm-devel           1.8.0-5
libgdbm3                1.8.3-1
libguile12              1.6.0-1
libguile14              1.5.6-5
libiconv                1.8-2
libiconv2               1.8-2
libintl                 0.10.38-3
libintl1                0.10.40-1
libintl2                0.11.5-1
libkpathsea3            2.0.2-1
libltdl3                20030216-1
libncurses5             5.2-1
libncurses6             5.2-8
libncurses7             5.3-1
libpng                  1.2.5-1
libpng10                1.0.15-1
libpng10-devel          1.0.15-1
libpng12                1.2.5-1
libpng12-devel          1.2.5-1
libpng2                 1.0.12-1
libpopt0                1.6.4-4
libPropList             0.10.1-3
libreadline4            4.1-2
libreadline5            4.3-2
libtool                 20020705-1
libtool-devel           20030216-1
libtool-stable          1.4.3-1
libungif                4.1.0-2
libxml2                 2.4.23-1
libxslt                 1.0.13-1
links                   0.96-1
login                   1.8-1
lynx                    2.8.4-5
m4                      1.4-1
make                    3.79.1-7
man                     1.5j-2
mc                      4.6.0-2
mingw                   20010424-1
mingw-runtime           2.4-1
mktemp                  1.4-1
more                    2.11o-1
mt                      2.0.1-1
mutt                    1.4-1
nano                    1.2.0-1
nasm                    0.98.36-1
ncftp                   3.1.4-1
ncurses                 5.3-1
newlib-man              20020801
opengl                  1.1.0-6
openssh                 3.6.1p1-1
openssl                 0.9.7b-1
openssl-devel           0.9.7b-1
openssl096              0.9.6j-1
patch                   2.5.8-3
pcre                    4.1-1
pdksh                   5.2.14-2
perl                    5.8.0-2
perl_manpages           5.8.0-2
pine                    4.53-1
pinfo                   0.6.6p1-1
pkgconfig               0.15.0-1
popt                    1.6.4-4
postgresql              7.3.2-1
procmail                3.22-7
procps                  010801-2
python                  2.2.2-7
rcs                     5.7-3
readline                4.3-2
rebase                  2.2-2
regex                   4.4-2
robots                  2.0-1
rsync                   2.5.6-1
rxvt                    2.7.10-3
sed                     4.0.5-1
sh-utils                2.0.15-3
sharutils               4.2.1-2
shutdown                1.2-2
squid                   2.4.STABLE7-1
ssmtp                   2.38.7-3
sunrpc                  4.0-1
swig                    1.3.19-1
sysvinit                2.84-3
tar                     1.13.25-1
tcltk                   20030214-1
tcp_wrappers            7.6-1
tcsh                    6.12.00-5
termcap                 20020930-1
terminfo                5.3-2
tetex                   2.0.2-1
tetex-base              2.0.2-1
tetex-beta              20020911-1
tetex-bin               2.0.2-1
tetex-doc               2.0.2-1
tetex-extra             2.0.2-1
tetex-tiny              2.0.2-1
tetex-x11               2.0.2-1
texinfo                 4.2-4
texmf                   20020911-1
texmf-base              20020911-1
texmf-doc               20020911-1
texmf-extra             20020911-1
texmf-tiny              20020911-1
textutils               2.0.21-1
tidy                    030201-1
tiff                    3.6.0-1
time                    1.7-1
tin                     1.4.7-1
ttcp                    19980512-1
ucl                     1.01-1
units                   1.77-1
unzip                   5.50-2
upx                     1.24-1
vim                     6.1.300-1
w32api                  2.3-1
wget                    1.8.2-2
which                   1.5-1
whois                   4.6.2-1
WindowMaker             0.80.0-2
XFree86-base            4.2.0-1
XFree86-bin             4.2.0-3
XFree86-etc             4.2.0-1
XFree86-f100            4.2.0-2
XFree86-fenc            4.2.0-2
XFree86-fnts            4.2.0-2
XFree86-lib             4.2.0-5
XFree86-man             4.2.0-1
XFree86-startup-scripts 4.2.0-3
XFree86-vfb             4.2.0-1
XFree86-xserv           4.2.0-29
XFree86-xwinclip        4.2.0-8
xinetd                  2.3.9-1
xpm                     4.0.0-2
xpm-nox                 4.2.0-1
zip                     2.3-2
zlib                    1.1.4-1
zsh                     4.0.6-5

Use -h to see help about each section

--6TrnltStXW4iwmi0--
