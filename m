Return-Path: <cygwin-patches-return-4776-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24981 invoked by alias); 19 May 2004 15:46:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24970 invoked from network); 19 May 2004 15:46:45 -0000
Date: Wed, 19 May 2004 15:46:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] To handle Win32 pipe names
Message-ID: <20040519154645.GJ1387@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY9-F265VSSFcl3imp0000784b@hotmail.com> <20040519085237.GA7011@cygbert.vinschen.de> <Pine.CYG.4.58.0405190959550.2628@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0405190959550.2628@fordpc.vss.fsi.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00128.txt.bz2

On May 19 10:08, Brian Ford wrote:
> On Wed, 19 May 2004, Corinna Vinschen wrote:
> 
> > So that explains your patch to symlink_info::check.  But it's not
> > exactly right to circumvent this only for pipes.  Any \\.\foo path
> > should get the same handling.  Wouldn't it be more straightforward to
> > use is_unc_share or a slightly modified version of is_unc_share?
> 
> I'm confused here.  Are you suggesting that UNC paths can't contain
> symlinks?

No.  It should be short-circuited for //./foo and //server/pipe/foo,
not for any other UNC path.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
