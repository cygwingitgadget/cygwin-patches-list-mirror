Return-Path: <cygwin-patches-return-3865-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6474 invoked by alias); 21 May 2003 15:48:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6410 invoked from network); 21 May 2003 15:48:44 -0000
Date: Wed, 21 May 2003 15:48:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Micha Nelissen <mdvpost@hotmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: Patch for line draw characters problem & screen scrolling
Message-ID: <20030521154842.GA1865@cygbert.vinschen.de>
Mail-Followup-To: Micha Nelissen <mdvpost@hotmail.com>,
	cygwin-patches@cygwin.com
References: <BAY1-DAV24HHGNZ4mF100020af2@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-DAV24HHGNZ4mF100020af2@hotmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00092.txt.bz2

On Wed, May 21, 2003 at 05:32:33PM +0200, Micha Nelissen wrote:
> Hi,
> 
> Several problems encountered and tried to fix:
> 
> 1) line draw characters not showing up in combination Command Prompt with
> bash.
> 2) screen scrolling fixed for termcap entry 'cs' -> screen split is very
> fast and cool.
> 3) end-of-buffer cursor out of range; see changelog for more details.
> 
> This is my first patch, so please don't flame ;). I am open to suggestions.
> 
> Regards,
> 
> Micha.

Thanks for the patch but nevertheless, there are two problems.

First of all, this is a big patch which requires an assignment
which copies over the copyright ownership to RedHat.

Second, the ChangeLog doesn't adhere to the ChangeLog standards.

Please have a look on http://cygwin.com/contrib.html.  As soon
as your assignment has been arrived at RedHat, we can look further
into your patch (and hopefully further patches).

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
