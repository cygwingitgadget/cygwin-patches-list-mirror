Return-Path: <cygwin-patches-return-3783-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5557 invoked by alias); 2 Apr 2003 21:52:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5544 invoked from network); 2 Apr 2003 21:52:19 -0000
Date: Wed, 02 Apr 2003 21:52:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: Re: cygwin_internal(CW_CHECK_NTSEC, filename) patch
In-reply-to: <20030402183304.GD3147@redhat.com>
To: cygwin-patches@cygwin.com
Mail-followup-to: cygwin-patches@cygwin.com
Message-id: <20030402184522.GC3064@tishler.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20030402131626.GA1888@tishler.net>
 <20030402154258.GA2614@redhat.com> <20030402182213.GA3064@tishler.net>
 <20030402183304.GD3147@redhat.com>
X-SW-Source: 2003-q2/txt/msg00010.txt.bz2

Chris,

On Wed, Apr 02, 2003 at 01:33:04PM -0500, Christopher Faylor wrote:
> On Wed, Apr 02, 2003 at 01:22:13PM -0500, Jason Tishler wrote:
> >I checked wincap before I started and somehow missed is_winnt().
> >Doh!  However, I could not find the equivalent of the
> >HAS_NTSEC_BY_DEFAULT functionality in wincap.  What other
> >functionality am I duplicating?
> 
> If you just do a path_conv on a path, you can check the 'has_acls ()'
> flag.  I think this just devolves to "allow_ntsec &&
> win32_path.has_acls ()".

Oops, sorry for missing this.  I will try again.

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6
