Return-Path: <cygwin-patches-return-3413-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1304 invoked by alias); 16 Jan 2003 19:06:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1292 invoked from network); 16 Jan 2003 19:06:15 -0000
Date: Thu, 16 Jan 2003 19:06:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: etc_changed, passwd & group.
Message-ID: <20030116190718.GA27321@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030116015721.007ee100@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030116015721.007ee100@mail.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00062.txt.bz2

On Thu, Jan 16, 2003 at 01:57:21AM -0500, Pierre A. Humblet wrote:
>Chris,
>
>Here is the code as it stands. It compiles & runs, and passes
>fork tests correctly. Feel free to takeover or at least
>have a look. I will continue testing tomorrow evening.
>
>I include only the 5 files that are related to etc_changed,
>the 5 others (setuid on Win9X) can wait.

Hmm.  I have a slightly less intrusive idea for how to handle this.  I'll
check it in shortly.

cgf
