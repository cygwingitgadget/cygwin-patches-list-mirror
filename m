Return-Path: <cygwin-patches-return-1703-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31501 invoked by alias); 15 Jan 2002 13:13:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31465 invoked from network); 15 Jan 2002 13:13:13 -0000
Date: Tue, 15 Jan 2002 05:13:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] mkpasswd.c - Central error reporting
Message-ID: <20020115141310.A2015@cygbert.vinschen.de>
Mail-Followup-To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
References: <911C684A29ACD311921800508B7293BA037D29EA@cnmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911C684A29ACD311921800508B7293BA037D29EA@cnmail>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00060.txt.bz2

On Sat, Jan 12, 2002 at 01:36:59PM -0500, Mark Bradshaw wrote:
> Attempt #2.  As per your request, all network error reporting is centralized
> in a single function I called print_win_error.  It gets an error code passed
> to it.  If it can manage to get a text message to go along with the code it
> will print an error in the form:
> mkpasswd [error #]: error text

Applied with two minor tweaks:

- Use %lu instead of %d format to avoid compiler warnings.
- Format is "mkpasswd: [%lu] %s" instead of "mkpasswd [%lu]: %s".

Thanks for the patch,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
