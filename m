Return-Path: <cygwin-patches-return-5269-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32282 invoked by alias); 22 Dec 2004 11:50:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25291 invoked from network); 22 Dec 2004 11:35:32 -0000
Received: from unknown (HELO cygbert.vinschen.de) (80.132.119.236)
  by sourceware.org with SMTP; 22 Dec 2004 11:35:32 -0000
Received: by cygbert.vinschen.de (Postfix, from userid 500)
	id 9D6605808D; Wed, 22 Dec 2004 12:35:31 +0100 (CET)
Date: Wed, 22 Dec 2004 11:50:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: Replace spaces with tabs in /proc/<pid>/status.
Message-ID: <20041222113531.GK9277@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <067301c4e80b$cd34a440$0207a8c0@avocado>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <067301c4e80b$cd34a440$0207a8c0@avocado>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q4/txt/msg00270.txt.bz2

On Dec 22 09:51, Chris January wrote:
> 2004-12-22  Chris January  <chris@atomice.net>
> 
> 	* fhandler_process.cpp (format_process_status): Use tabs in
> formatting
> 	instead of spaces.

Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
