Return-Path: <cygwin-patches-return-1723-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21427 invoked by alias); 17 Jan 2002 02:54:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21402 invoked from network); 17 Jan 2002 02:54:31 -0000
Date: Wed, 16 Jan 2002 18:54:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: FW: fnmatch
Message-ID: <20020117025454.GB15091@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <911C684A29ACD311921800508B7293BA037D2A3B@cnmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911C684A29ACD311921800508B7293BA037D2A3B@cnmail>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00080.txt.bz2

On Wed, Jan 16, 2002 at 09:51:07PM -0500, Mark Bradshaw wrote:
>I would, but it'd be kinda incomplete.  As I said, I would need some
>guidance on getting locale specific strings.  At the moment, about 4-5
>locations (if memory serves) have hard coded strings whereas in OpenBSD
>their locale specific.  
>
>If we use yours, or I finish mine...I don't mind either way.  I didn't pipe
>up to push what I'd done.  

I'll wager (without looking at the code, in true !cygwin! style) that
Robert's implementation doesn't take locales into consideration either.

cgf
