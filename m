Return-Path: <cygwin-patches-return-2184-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1568 invoked by alias); 13 May 2002 19:36:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1550 invoked from network); 13 May 2002 19:36:54 -0000
Subject: Re: [PATCH] strlcat & strlcpy
From: Thomas Fitzsimmons <fitzsim@redhat.com>
To: Mark Bradshaw <bradshaw@staff.crosswalk.com>
Cc: "'newlib@sources.redhat.com'" <newlib@sources.redhat.com>,
        cygwin-patches@cygwin.com
In-Reply-To: <911C684A29ACD311921800508B7293BA037D2FC6@cnmail>
References: <911C684A29ACD311921800508B7293BA037D2FC6@cnmail>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 13 May 2002 12:36:00 -0000
Message-Id: <1021318610.30181.68.camel@toggle>
Mime-Version: 1.0
X-SW-Source: 2002-q2/txt/msg00168.txt.bz2

On Fri, 2002-05-10 at 18:28, Mark Bradshaw wrote:
> Here's a patch to cygwin and newlib that adds the functions strlcat and
> strlcpy.  These functions are replacement functions for strncat and strncpy.
> They were created by the OpenBSD team to address buffer overflow problems
> that can happen so easily when using the "n" versions.  Some other OS's have
> picked them up already, and software packages have begun to use them when
> available.  Aside from security benefits there are also performance
> benefits.  Strlcat is much faster than strncat, due to strncat's penchant
> for padding the destination string.
> 
> The original source for these two come from OpenBSD.  You can find them
> here:
> http://www.openbsd.org/cgi-bin/cvsweb/src/lib/libc/string/
> 
> A good discussion of the new functions can be found here:
> http://www.courtesan.com/todd/papers/strlcpy.html
>

I've applied this, with one change.  I moved the string.h declarations
to the !__STRICT_ANSI__ section of that file.

Do you have any tests for these functions that you would like to
contribute to our new testsuite?

Tom


> ===================
> 
> For newlib:
> 2002-05-10  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
>         * libc/include/string.h: Add strlcat and strlcpy.
>         * libc/string/Makefile.am: Add strlcat.c and strlcpy.c.
>         * libc/string/strlcat.c: New file.
>         * libc/string/strlcpy.c: New file.
> 
> For cygwin:
> 2002-05-10  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
> 
> 	  * cygwin.din: Add strlcat and strlcpy.
> 	  * include/cygwin/version.h: Increment API minor version number.
> 
-- 
Thomas Fitzsimmons
Red Hat Canada Limited        e-mail: fitzsim@redhat.com
2323 Yonge Street, Suite 300
Toronto, ON M4P2C9
