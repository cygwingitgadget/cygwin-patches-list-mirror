Return-Path: <cygwin-patches-return-4510-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22807 invoked by alias); 7 Jan 2004 17:33:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22798 invoked from network); 7 Jan 2004 17:33:20 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Wed, 07 Jan 2004 17:33:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: Re: lstat symbolic link size
In-Reply-To: <20040106014410.GA6850@redhat.com>
Message-ID: <Pine.GSO.4.58.0401071123210.23399@eos>
References: <20040106013026.21604.qmail@linuxmail.org> <20040106013824.GA6047@redhat.com>
 <20040106014410.GA6850@redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-801093841-1073496798=:23399"
X-SW-Source: 2004-q1/txt/msg00000.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-801093841-1073496798=:23399
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 3478

On Mon, 5 Jan 2004, Christopher Faylor wrote:

> On Mon, Jan 05, 2004 at 08:38:24PM -0500, Christopher Faylor wrote:
> >On Tue, Jan 06, 2004 at 09:30:26AM +0800, peter garrone wrote:
> >>lstat returns an incorrect symbolic link size, with size 11 bytes too large.
> >>
> >lstat reports the actual size of the symlink file.  Unless you can point
> >to a standard which indicates this is incorrect, we'll be sticking with
> >this long standing behavior.
> >
> Actually, nevermind.  SUSv3 says this:
>
> For symbolic links, the st_mode member shall contain meaningful
> information when used with the file type macros, and the st_size member
> shall contain the length of the pathname contained in the symbolic link.
>
> So, this is a PTC situation.
>
Ok, here it is.

2004-01-07  Brian Ford  <ford@vss.fsi.com>

	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Comply with
	SUSv3 for a symlink's st_size, ie. the length of the target
	pathname.

Note that this is untested as current CVS suffers from a problem similar
to the last one reported here:

http://www.cygwin.com/ml/cygwin/2004-01/msg00041.html

Details in case they are usefull:

$ env PATH="../../cygwin:${PATH}" gdb ./checksignal.exe
GNU gdb 5.3
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-cygwin"...
(gdb) r
Starting program: /home/ford/downloads/cygb2/i686-pc-cygwin/winsup/testsuite/testsuite/checksignal.exe

Program received signal SIGSEGV, Segmentation fault.
[Switching to thread 364.0x152]
0x00aee654 in ?? ()
(gdb) bt
#0  0x00aee654 in ?? ()
#1  0x610041b8 in _threadinfo::call(unsigned long (*)(void*, void*), void*) (
    func=0xaee650, arg=0xaee414)
    at ../../../../cygwin/winsup/cygwin/cygtls.cc:44
#2  0x610041b8 in _threadinfo::call(unsigned long (*)(void*, void*), void*) (
    func=0xaee650, arg=0xaee414)
    at ../../../../cygwin/winsup/cygwin/cygtls.cc:44
(gdb) info threads
* 2 thread 364.0x152  0x00aee654 in ?? ()
  1 thread 364.0x1a5  _mbtowc_r (r=0x22e650, pwc=0x22e1d8,
    s=0x6101df41 "cYgstd %x %x %x", n=2286176, state=0x22e278)
    at ../../../../../cygwin/newlib/libc/stdlib/mbtowc_r.c:56
(gdb) thread 1
[Switching to thread 1 (thread 364.0x1a5)]#0  _mbtowc_r (r=0x22e650,
    pwc=0x22e1d8, s=0x6101df41 "cYgstd %x %x %x", n=2286176, state=0x22e278)
    at ../../../../../cygwin/newlib/libc/stdlib/mbtowc_r.c:56
56      {
(gdb) bt
#0  _mbtowc_r (r=0x22e650, pwc=0x22e1d8, s=0x6101df41 "cYgstd %x %x %x",
    n=2286176, state=0x22e278)
    at ../../../../../cygwin/newlib/libc/stdlib/mbtowc_r.c:56
#1  0x610dac61 in sprintf (str=0x22e278 "+", fmt=0x6101df41 "cYgstd %x %x %x")
    at ../../../../../cygwin/newlib/libc/stdio/sprintf.c:373
#2  0x6101dfc0 in dtable::get_debugger_info() (this=0x6167018c)
    at ../../../../cygwin/winsup/cygwin/dtable.cc:104
#3  0x610ab562 in tty_init() () at ../../../../cygwin/winsup/cygwin/tty.cc:61
#4  0x610056ab in dll_crt0_1(char*) ()
    at ../../../../cygwin/winsup/cygwin/dcrt0.cc:685
#5  0x6100616a in _dll_crt0 () at ../../../../cygwin/winsup/cygwin/dcrt0.cc:913
(gdb) q

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-801093841-1073496798=:23399
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fhandler_disk_file.cc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0401071133180.23399@eos>
Content-Description: 
Content-Disposition: attachment; filename="fhandler_disk_file.cc.patch"
Content-length: 1042

SW5kZXg6IGZoYW5kbGVyX2Rpc2tfZmlsZS5jYw0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2lu
L2ZoYW5kbGVyX2Rpc2tfZmlsZS5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuNzUNCmRpZmYgLXUgLXAgLXIxLjc1IGZoYW5kbGVyX2Rpc2tfZmlsZS5j
Yw0KLS0tIGZoYW5kbGVyX2Rpc2tfZmlsZS5jYwkxNSBEZWMgMjAwMyAwNDox
Njo0MiAtMDAwMAkxLjc1DQorKysgZmhhbmRsZXJfZGlza19maWxlLmNjCTcg
SmFuIDIwMDQgMTc6MjM6MTAgLTAwMDANCkBAIC0yOTEsNiArMjkxLDggQEAg
ZmhhbmRsZXJfYmFzZTo6ZnN0YXRfaGVscGVyIChzdHJ1Y3QgX19zdA0KICAg
ICB7DQogICAgICAgLyogc3ltbGlua3MgYXJlIGV2ZXJ5dGhpbmcgZm9yIGV2
ZXJ5b25lISAqLw0KICAgICAgIGJ1Zi0+c3RfbW9kZSA9IFNfSUZMTksgfCBT
X0lSV1hVIHwgU19JUldYRyB8IFNfSVJXWE87DQorICAgICAgLyogU1VTdjM6
IHRoZWlyIHNpemUgaXMgdGhlIGxlbmd0aCBvZiB0aGUgdGFyZ2V0IHBhdGhu
YW1lICovDQorICAgICAgYnVmLT5zdF9zaXplID0gc3RybGVuIChwYy5nZXRf
d2luMzIgKCkpOw0KICAgICAgIGdldF9maWxlX2F0dHJpYnV0ZSAocGMuaGFz
X2FjbHMgKCksIGdldF93aW4zMl9uYW1lICgpLCBOVUxMLA0KIAkJCSAgJmJ1
Zi0+c3RfdWlkLCAmYnVmLT5zdF9naWQpOw0KICAgICAgIGdvdG8gZG9uZTsN
Cg==

---559023410-801093841-1073496798=:23399--
