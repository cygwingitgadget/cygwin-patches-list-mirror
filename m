Return-Path: <cygwin-patches-return-2351-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28895 invoked by alias); 6 Jun 2002 15:36:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28880 invoked from network); 6 Jun 2002 15:36:40 -0000
Date: Thu, 06 Jun 2002 08:36:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for sub-second resolution in stat(2)
Message-ID: <20020606173638.K22789@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01ae01c20cf5$551007f0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ae01c20cf5$551007f0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00334.txt.bz2

On Thu, Jun 06, 2002 at 01:58:55AM +0100, Conrad Scott wrote:
> [Second attempt once I'd calmed down enough to get it right.]
> 
> Attached is a patch that adds sub-second resolution to the access,
> modification, and creation times returned by stat(2) etc. I thought this
> would make a nice companion to Corinna's work on making other things in
> stat(2) be 64-bit.

Applied.  As already noted on the newlib mailing list, I've moved
the typedefs of timespec_t and timestruc_t to our own types.h in
winsup/cygwin/include/cygwin/types.h.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
