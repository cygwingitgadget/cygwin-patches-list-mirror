Return-Path: <cygwin-patches-return-3372-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1704 invoked by alias); 10 Jan 2003 12:19:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1641 invoked from network); 10 Jan 2003 12:19:36 -0000
Date: Fri, 10 Jan 2003 12:19:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] export asprintf and friends
Message-ID: <20030110131923.H1401@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3E13C60B.4000904@ece.gatech.edu> <3E19EE90.7030502@ece.gatech.edu> <3E1A24A3.9040807@ece.gatech.edu> <3E1B0FF7.2040809@ece.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1B0FF7.2040809@ece.gatech.edu>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2003-q1/txt/msg00021.txt.bz2

On Tue, Jan 07, 2003 at 12:35:51PM -0500, Charles Wilson wrote:
> 2003-01-01  Charles Wilson  <cwilson@ece.gatech.edu>
> 
> 	* winsup/cygwin/cygwin.din: add asprintf and
> 	vasprintf, as well as the reentrant versions and
> 	underscore variants.
> 	* winsup/cygwin/include/cygwin/version.h: bump
> 	CYGWIN_VERSION_API_MINOR

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
