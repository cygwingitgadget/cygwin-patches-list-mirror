Return-Path: <cygwin-patches-return-1781-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21905 invoked by alias); 25 Jan 2002 08:53:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21870 invoked from network); 25 Jan 2002 08:53:36 -0000
Subject: Re: [PATCH]Package extention recognition (revision 1)
From: Robert Collins <robert.collins@itdomain.com.au>
To: Michael A Chase <mchase@ix.netcom.com>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <015c01c1a54c$3a4bfac0$a100a8c0@mchasecompaq>
References: <003f01c1a542$742968e0$a100a8c0@mchasecompaq>
	<20020125015129.GA16592@redhat.com> 
	<015c01c1a54c$3a4bfac0$a100a8c0@mchasecompaq>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Fri, 25 Jan 2002 00:53:00 -0000
Message-Id: <1011948812.18172.17.camel@lifelesswks>
Mime-Version: 1.0
X-OriginalArrivalTime: 25 Jan 2002 08:53:35.0587 (UTC) FILETIME=[C6156330:01C1A57D]
X-SW-Source: 2002-q1/txt/msg00138.txt.bz2

On Fri, 2002-01-25 at 13:58, Michael A Chase wrote:
> ----- Original Message -----
> From: "Christopher Faylor" <cgf@redhat.com>
> To: <cygwin-patches@cygwin.com>
> Sent: Thursday, January 24, 2002 17:51
> Subject: Re: [PATCH]Package extention recognition
> 
> 
> > On Thu, Jan 24, 2002 at 05:48:35PM -0800, Michael A Chase wrote:
> > >I noticed that find_tar_ext() always returns after checking for
> ".tar.bz2"
> > >and ".tar.gz" so it never gets to the check for ".tar".  As long as I was
> > >fixing that, it seemed like a good time to add ".cwp" as an accepted file
> > >extension.
> >
> > Haven't we already debated this issue?  I don't see any reason to inflict
> > a .cwp on the world and I can't imagine why we'd ever want a plain .tar
> > rather than a .tar.bz2.
> 
> The last discussion I saw on ".cwp" kind of wandered off when someone
> offered a patch that was more complicated than necessary.  It seemed like a
> good idea (along with .deb or rpm) to avoid the next round of 'Why doesn't
> the install I did with WinZip not work?', but I can easily change the patch
> remove both.

.cwp was an idea to avoid Winzip users - but .bz2 does that too, as will
deb or rpm. The previous patch wasn't rejected due to complexity, but
due to incompleteness - it was a partial factoring, but didn't make the
code easier to maintain or extend, as generic magic number support
(which is present now) does. (ie when you pass a stream to
archive::open, the extension doesn't matter, only the content. Ditto for
decompressing.
 
> The current un-patched code leaves off ".tar" inadvertently.

If that isthe filemanip code, it seems fine to me, or perhaps you got
your patch arguments the wrong way around for that file?
 
> The revised patch is identical to the previous one except that the tests for
> ".cwp", and ".tar" are removed from find_tar_ext().

Ok, some feedback: strdup is deprecated except where it's needed to
interface with a C-library that deallocates via the malloc family.. Use
new char[n+1] and strcpy. Eventually we'll either roll our own string
class, grab an existing one, or use the STL.

Regarding the source file tests, that approach looks ok. Long term it
will be something like:
find a binary,
extract metadata,
check for the source file(s) (which are explicitly named in the
metadata).

I'll apply the lot if you'll
1) cleanup the strduping,
2) Answer my query about filemanip.

Cheers,
Rob


> --
> Mac :})
> ** I normally forward private questions to the appropriate mail list. **
> Give a hobbit a fish and he eats fish for a day.
> Give a hobbit a ring and he eats fish for an age.
> 
> Change (with .cwp and .tar removed):
> 
> 2002-01-24  Michael A Chase <mchase@ix.netcom.com>
> 
>     * filemanip.cc (find_tar_ext): Clean up extensions tests.
>     * fromcwd.cc (do_fromcwd): Try same extension as binary archive for -src
>     archive before falling back to .tar.bz2 or .tar.gz.
>     * install.cc (install_one_source): Add space between words in log()
> call.
> 

