Return-Path: <cygwin-patches-return-3321-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25560 invoked by alias); 15 Dec 2002 10:10:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25551 invoked from network); 15 Dec 2002 10:10:32 -0000
Date: Sun, 15 Dec 2002 02:10:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: {get,set}facl.c (part of ntsec, inheritance and sec_acl)
Message-ID: <20021215111028.W19104@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20021214173216.007dcaa0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20021214173216.007dcaa0@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q4/txt/msg00272.txt.bz2

On Sat, Dec 14, 2002 at 05:32:16PM -0500, Pierre A. Humblet wrote:
> 2002-12-14  Pierre Humblet <pierre.humblet@ieee.org>
> 
> 	* setfacl.c (main): Place a single : after other and mask.
> 	* getfacl.c (getaclentry): Allow both : and :: for other and mask.
> 	(main): Remove extraneous break.

Thanks, applied,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
