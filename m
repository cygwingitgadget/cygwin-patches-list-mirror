Return-Path: <cygwin-patches-return-3968-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10907 invoked by alias); 17 Jun 2003 01:19:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10874 invoked from network); 17 Jun 2003 01:19:48 -0000
Date: Tue, 17 Jun 2003 01:19:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: exceptions.cc - stackdump file - patch to identify version and build date
Message-ID: <20030617011945.GA4354@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3EE9BA02.7080502@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE9BA02.7080502@yahoo.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00195.txt.bz2

On Fri, Jun 13, 2003 at 07:48:18AM -0400, Earnie Boyd wrote:

>2003-06-13  Earnie Boyd  <earnie@users.sf.net>
>
>	* exceptions.cc (exception): Output version and build date information
>	to the stackdump.

If you are going to include the version and build date in the stackdump
file, you might as well do so in a manner consistent with uname, even
down to including OS and processor type.

Unfortunately, doing this might mean that the patch would be less than
trivial (and this patch is borderline since it adds new functionality)
so that would mean that you'd need an assignment on file with Red Hat
for the patch to be provided, which, I believe, is not the case for
you.

cgf
