Return-Path: <cygwin-patches-return-3781-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27952 invoked by alias); 2 Apr 2003 18:33:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27943 invoked from network); 2 Apr 2003 18:33:00 -0000
Date: Wed, 02 Apr 2003 18:33:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin_internal(CW_CHECK_NTSEC, filename) patch
Message-ID: <20030402183304.GD3147@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030402131626.GA1888@tishler.net> <20030402154258.GA2614@redhat.com> <20030402182213.GA3064@tishler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402182213.GA3064@tishler.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q2/txt/msg00008.txt.bz2

On Wed, Apr 02, 2003 at 01:22:13PM -0500, Jason Tishler wrote:
>On Wed, Apr 02, 2003 at 10:42:58AM -0500, Christopher Faylor wrote:
>> Why are you essentially duplicating all of the checking that already
>> happens with the wincap stuff?
>
>I checked wincap before I started and somehow missed is_winnt().  Doh!
>However, I could not find the equivalent of the HAS_NTSEC_BY_DEFAULT
>functionality in wincap.  What other functionality am I duplicating?

If you just do a path_conv on a path, you can check the 'has_acls ()'
flag.  I think this just devolves to "allow_ntsec && win32_path.has_acls ()".

cgf
