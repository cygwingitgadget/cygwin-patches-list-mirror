Return-Path: <cygwin-patches-return-2039-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27266 invoked by alias); 9 Apr 2002 23:42:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27248 invoked from network); 9 Apr 2002 23:42:55 -0000
Date: Tue, 09 Apr 2002 16:42:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: Mark Bradshaw <bradshaw@staff.crosswalk.com>
Cc: "'newlib@sources.redhat.com'" <newlib@sources.redhat.com>,
   cygwin-patches@cygwin.com
Subject: Re: patch: strptime
Message-ID: <20020409234252.GD18953@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Bradshaw <bradshaw@staff.crosswalk.com>,
	"'newlib@sources.redhat.com'" <newlib@sources.redhat.com>,
	cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23.1i
yn-Reply-To: <911C684A29ACD311921800508B7293BA037D2E76@cnmail>
X-SW-Source: 2002-q2/txt/msg00023.txt.bz2

On Tue, Apr 09, 2002 at 03:52:18PM -0400, Mark Bradshaw wrote:
>For cygwin:
>2002-04-09  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
>
>	  * cygwin.din: Add strptime.
>	  * include/cygwin/version.h: Increment minor version number.

I've checked this in with one fix.  You don't increment the minor
version number when a new function is added.  That would have changed
the cygwin version to 1.3.11.  Instead, you increment the API minor
number when you export a new function.  This is what I've done.

cgf
