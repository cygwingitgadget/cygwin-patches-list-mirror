Return-Path: <cygwin-patches-return-2575-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7575 invoked by alias); 2 Jul 2002 01:37:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7561 invoked from network); 2 Jul 2002 01:37:22 -0000
Date: Mon, 01 Jul 2002 18:37:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for /proc/registry and other /proc stuff
Message-ID: <20020702013730.GE14478@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <014401c22163$43bd8d10$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014401c22163$43bd8d10$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00023.txt.bz2

On Tue, Jul 02, 2002 at 01:56:13AM +0100, Chris January wrote:
>* fixed bug where EISDIR was not set when trying to open a registry key.
>* lseek now refreshes the file contents buffer for registry values.
>* typo fixed (s/<defunct/<defunct>).
>* fixed bug where contents of /proc/<pid>/<file> where not updated when
>lseek was called.
>* fstat now returns useful information about registry keys.
>* cleaned up handling of access permissions on registry keys.
>* new function in security.cc returns security information for NT objects.

Applied, with some formatting tweaks.

I ran fhandler_registry.cc through indent.  I don't know if that helped or
hurt, though.

Thanks.

I think this is a wrap for 1.3.12, unless someone has something urgent...

cgf
