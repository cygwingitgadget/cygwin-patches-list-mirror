Return-Path: <cygwin-patches-return-3787-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8455 invoked by alias); 3 Apr 2003 14:01:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8446 invoked from network); 3 Apr 2003 14:01:14 -0000
Date: Thu, 03 Apr 2003 14:01:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: cygwin_internal(CW_CHECK_NTSEC, filename) patch
In-reply-to: <20030403081916.GI18138@cygbert.vinschen.de>
To: cygwin-patches@cygwin.com
Mail-followup-to: cygwin-patches@cygwin.com
Message-id: <20030403140041.GB2544@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20030402183304.GD3147@redhat.com>
 <20030402131626.GA1888@tishler.net> <20030402154258.GA2614@redhat.com>
 <20030402182213.GA3064@tishler.net> <20030402183304.GD3147@redhat.com>
 <3.0.5.32.20030402232929.007fd540@incoming.verizon.net>
 <20030403081916.GI18138@cygbert.vinschen.de>
X-SW-Source: 2003-q2/txt/msg00014.txt.bz2

On Thu, Apr 03, 2003 at 10:19:16AM +0200, Corinna Vinschen wrote:
> On Wed, Apr 02, 2003 at 11:29:29PM -0500, Pierre A. Humblet wrote:
> > this might return true on Win9X if a user has defined
> > CYGWIN=ntsec and checks a file mounted on an NT class machine.
> > You need to add && wincap.has_security().
> > 
> > Also, it's sometimes useful to know the value of allow_ntsec alone.
> > Could you return that, e.g. if filename is NULL?
> 
> I've checked in a patch.

Thanks for everyone's help.  For some reason, the "How many foos are
needed to change a light bulb?" jokes come to mind... :,)

Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6
