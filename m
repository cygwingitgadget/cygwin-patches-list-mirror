Return-Path: <cygwin-patches-return-3318-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13652 invoked by alias); 14 Dec 2002 17:24:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13642 invoked from network); 14 Dec 2002 17:24:45 -0000
Date: Sat, 14 Dec 2002 09:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Small security patches
Message-ID: <20021214182443.Q19104@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DF76981.86674258@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF76981.86674258@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00269.txt.bz2

On Wed, Dec 11, 2002 at 11:36:17AM -0500, Pierre A. Humblet wrote:
> 	* security.h: Declare well_known_creator_group_sid.
> 	* sec_helper.cc: Declare and initialize well_known_creator_group_sid.

Ok, I've applied this together with my new (slightly changed) cygsid
initializer method.

Thanks Pierre,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
