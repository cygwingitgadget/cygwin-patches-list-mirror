Return-Path: <cygwin-patches-return-1558-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12412 invoked by alias); 4 Dec 2001 04:22:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12397 invoked from network); 4 Dec 2001 04:22:46 -0000
Date: Thu, 01 Nov 2001 05:38:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
Message-ID: <20011204042254.GB9987@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <911C684A29ACD311921800508B7293BA037D2827@cnmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911C684A29ACD311921800508B7293BA037D2827@cnmail>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00090.txt.bz2

On Mon, Dec 03, 2001 at 09:24:47PM -0500, Mark Bradshaw wrote:
>It just occurred to me that the patch I submitted for mkpasswd.c causes one
>of its error messages to be a bit misleading.  If you ask mkpasswd for a
>user that doesn't exist it will say:
>"NetUserEnum() failed with error 2221.
>That user doesn't exist."
>
>While the error number is correct, and the explanation on the second line is
>right, it's not actually NetUserEnum that's been called to determine that.
>I don't know if you care about this, but maybe the following patch could be
>thrown in to make that error a bit more generic (and correct).

I agree that the user doesn't have to know about NetUserEnum but the
error message should be something like "mkpasswd: user doesn't exist".

Some of the messages are like this already.  Are you interested in
genercizing the rest of the mkpasswd warnings?

cgf

>===============================
>
>2001-12-03  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
>
>	* mkpasswd.c: (enum_users): Fix an error message.
>
>===============================
