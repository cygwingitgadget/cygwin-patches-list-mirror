Return-Path: <cygwin-patches-return-3639-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1384 invoked by alias); 27 Feb 2003 17:44:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1358 invoked from network); 27 Feb 2003 17:44:22 -0000
Date: Thu, 27 Feb 2003 17:44:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: updating the internal copy of the gsid
Message-ID: <20030227174421.GB24097@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030226222310.007fcb40@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030226222310.007fcb40@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00288.txt.bz2

On Wed, Feb 26, 2003 at 10:23:10PM -0500, Pierre A. Humblet wrote:
> 2003-02-27  Pierre Humblet  <pierre.humblet@ieee.org>
>  
> 	* uinfo.cc (internal_getlogin): Only update user.groups.pgsid
> 	if the call to set the primary group succeeds.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
