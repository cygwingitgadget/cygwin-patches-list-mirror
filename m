Return-Path: <cygwin-patches-return-3412-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12088 invoked by alias); 16 Jan 2003 15:39:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12076 invoked from network); 16 Jan 2003 15:39:37 -0000
Date: Thu, 16 Jan 2003 15:39:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: NT 4.0 fixup_mmaps_after_fork() patch
In-reply-to: <20030116141135.GC1373@cygbert.vinschen.de>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20030116154701.GA820@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20030115191918.GA1016@tishler.net>
 <20030116141135.GC1373@cygbert.vinschen.de>
X-SW-Source: 2003-q1/txt/msg00061.txt.bz2

Corinna,

On Thu, Jan 16, 2003 at 03:11:35PM +0100, Corinna Vinschen wrote:
> On Wed, Jan 15, 2003 at 02:19:19PM -0500, Jason Tishler wrote:
> > It appears that ReadProcessMemory() can fail with ERROR_NOACCESS
> > under NT 4.0.  See attached patch.
> 
> Applied.  Thanks!

You are welcome.

> > BTW, my mmap-test test case works under NT 4.0 without this patch.
> > However, vsFTPd does not.  Go figure!
> 
> Details?

Um... Er... Cockpit error.  I still had the mprotect() calls commented
out.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6
