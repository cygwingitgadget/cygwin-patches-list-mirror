Return-Path: <cygwin-patches-return-1946-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27584 invoked by alias); 4 Mar 2002 22:46:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27555 invoked from network); 4 Mar 2002 22:46:39 -0000
Date: Mon, 04 Mar 2002 15:28:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: RFC: Silence pedantic warnings at header file level
Message-ID: <20020304224635.GB18528@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020304224414.13778.qmail@web14510.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020304224414.13778.qmail@web14510.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00303.txt.bz2

On Tue, Mar 05, 2002 at 09:44:14AM +1100, Danny Smith wrote:
>GCC 3.x has a a new pragma that causes the rest of the code in
>the current file to be treated as if it came from a system header
>
>Putting this right after the header guard of runtime and w32api headers
>would silence all the "long long"  and bitfield pedantic warnings that
>still occur.  It would also allow cleanup of the anonymous union
>__extension__ business.
>
>#if defined __GNUC__ && __GNUC__ >= 3
>#pragma GCC system_header
>#endif
>
>
>This approach is used in GCC's STL headers.
>
>Any comments

Looks good to me.  Do you really need the defined __GNUC__ part, though?
Don't unknown symbols default to zero?

cgf
