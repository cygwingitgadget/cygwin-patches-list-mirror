Return-Path: <cygwin-patches-return-3491-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10870 invoked by alias); 4 Feb 2003 17:53:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10851 invoked from network); 4 Feb 2003 17:53:39 -0000
Date: Tue, 04 Feb 2003 17:53:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: handle leak in internal_getgroups
Message-ID: <20030204175337.GJ5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030204113915.007f5b20@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030204113915.007f5b20@mail.attbi.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00140.txt.bz2

On Tue, Feb 04, 2003 at 11:39:15AM -0500, Pierre A. Humblet wrote:
> 2003/02/04  Pierre Humblet  <pierre.humblet@ieee.org>
>  
> 	* grp.cc (internal_getgroups): Do not return without closing
> 	the process handle.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
