Return-Path: <cygwin-patches-return-4329-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19567 invoked by alias); 30 Oct 2003 21:15:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19541 invoked from network); 30 Oct 2003 21:15:46 -0000
Message-ID: <3FA17F7B.1010701@netscape.net>
Date: Thu, 30 Oct 2003 21:15:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add PAGE_SIZE, PAGE_SHIFT, PAGE_MASK to sys/param.h
References: <3F9F1C5B.2050501@netscape.net> <20031029093534.GB22720@cygbert.vinschen.de> <3F9FE3C5.9050505@netscape.net> <20031029173358.GL1653@cygbert.vinschen.de> <3FA05514.3000000@netscape.net> <20031030091156.GA31416@cygbert.vinschen.de>
In-Reply-To: <20031030091156.GA31416@cygbert.vinschen.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.187
X-SW-Source: 2003-q4/txt/msg00048.txt.bz2

cygwin-patches@cygwin.com wrote:
> On Wed, Oct 29, 2003 at 07:02:28PM -0500, Nicholas Wourms wrote:
> 
>>  Still, perhaps Brian's 
>>suggestion has some merit?
> 
> 
> Yes.  The Solaris-like definition has its point.  Using sysconf or
> getpagesize in the macro is fine.

OK I'll work something up then.

> 
>>Which brings up another matter, asm/socket.h.  Can someone point me to 
>>what source we should use when defining if ioctl macros in asm/socket.h. 
> 
> 
> Aren't these BSD based?  However, when I introduced SIOCGIFADDR and
> friends back in 1998, I didn't look anywhere besides the already existing
> definitions for SIOCGIFCONF and SIOCGIFFLAGS in Cygwin's asm/socket.h.
> I've just used the next values in the row and they were accepted that
> way by Geoff.

Indeed, they seem to be loosely based off of BSD.  Linux, as you'll 
notice, just defines them outright.  From what I can tell, the 
equivalent of our asm/socket.h would be in the following two files from 
FreeBSD (incidently this is similar in the other BSD's and Newlib/ELIX 
as well):

http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/sys/ioccom.h?rev=1.14&content-type=text/x-cvsweb-markup
http://www.freebsd.org/cgi/cvsweb.cgi/src/sys/sys/sockio.h?rev=1.25&content-type=text/x-cvsweb-markup

Of course Sun's headers tell a slightly different story:

http://www.mit.edu/afs/athena/astaff/project/bootkit/solarisinstall/29/source/proto/usr/include/sys/ioccom.h
http://www.mit.edu/afs/athena/astaff/project/bootkit/solarisinstall/29/source/proto/usr/include/sys/sockio.h

However, linux actually documents this system, which I assume is similar 
in nature to the svr4/bsd system.  I found it quite thorough in 
detailing the parameters for this system:

http://linus.bkbits.net:8080/linux-2.5/anno/Documentation/ioctl-number.txt@1.11?nav=index.html|src/.|src/Documentation

I just want to make sure that I do the right thing.  The numbering seems 
arbitrary, however I could be wrong.  I just wonder why none of our 
ioctls are _IOWR, when they are defined that way for bsd/linux?  Perhaps 
this is a limitation of the winsock?  It could be that I'm just making a 
big deal over nothing, but I wanted to check first.

> 
>> Both bind and bsd seem to have very different definitions in terms of 
>>the read/write capabilities of the ioctls...
> 
> 
> Don't bother.  Is it a value which could be changed in Cygwin or Winsock?

I don't know, I guess I'll just make it 108 and see what happens.  The 
group code seems to be arbitrary as well, so I'll just stick with the 
flow and use `i'.

> What are you trying to implement?  I'm really curious.

Well it started when I was fiddling around with some software which 
wanted the SIOCGIFDSTADDR ioctl.  This ioctl and it's companion, 
SIOCGIFDSTADDR, are similar to {SIOCG,SIOCS}IFBRDADDR, but are used for 
point-to-point addresses as opposed to broadcast addresses.  Anyhow, 
while researching this I noticed that bind already has some code to deal 
with this ioctl on Windows platforms.  I was planning to see what I can 
do about porting some of it into our code, as it seemed like rather 
small affair.  If not, based on my research of the bsd code, it ought to 
be somewhat similar to how our SIOCGIFBRDADDR is done.  I figure I could 
just tinker around with that approach if all else fails.  Admittedly, 
I'm learning as I go, so I know I'm bound to stumble somewhere (Gee, a 
copy of unix network programming 2nd edition would come in handy right 
about now).  Still, I'm confident that getting a working implementation 
is possible, it just may take some trial and error.  Not to rant, but 
our network sockets seems lacking in a few areas, so I hope to 
contribute there.  So that's what I'm up to these days.  I still have a 
boatload of missing c99/susv3 functions which I've yet to submit to 
newlib, but as usual I've gotten sidetracked by YA pet project...

I know I'm asking for a flame, but looking at the watt32s[1] project got 
me thinking.  The current person working on ipv6 for Cygwin[2] is 
leveraging XP's winsock's ipv6 stack to add ipv6 support to Cygwin. 
However, It's really annoying that MS refuses to fully backport a 
completely functional ipv6 stack to win2k (let alone win9x/ME).  So, if 
win2k users want it, they are stuck with a crusty old, incomplete, 
"experimental" version instead.  If you're a Win9x/ME users, then it's 
too bad.  Anyhow, for those who don't know, the watt32s project aims to 
bring a fully compliant and fully featured bsd network socket layer to 
djgpp/DOS/mingw32.  It's incredible how much they've actually managed to 
impliment without using a winsock.  Maybe something at a lower level is 
the answer, maybe not, but it sure would be nice to have a network layer 
which wasn't restricted based what version of winsock you have.

Cheers,
Nicholas

[1] http://www.bgnett.no/~giva/
[2] http://win6.jp/Cygwin/
