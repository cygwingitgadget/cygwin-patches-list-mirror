Return-Path: <cygwin-patches-return-4233-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2355 invoked by alias); 25 Sep 2003 02:52:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2346 invoked from network); 25 Sep 2003 02:52:36 -0000
Date: Thu, 25 Sep 2003 02:52:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fixing the delete queue security
Message-ID: <20030925025226.GA13154@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030915211808.0081d6d0@incoming.verizon.net> <20030925004355.GA13801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925004355.GA13801@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00249.txt.bz2

On Wed, Sep 24, 2003 at 08:43:55PM -0400, Christopher Faylor wrote:
>Please check in.  You'll have to accommodate the new layout after my
>checkin but it should apply with only minor problems.

I just built cygwin with these changes and noticed the warnings due to
MOUNT_MAGIC changing.

I should have mentioned that you really do need to update the
MOUNT_MAGIC value prior to checkin.  All you have to do is edit the
shared_info.h file.  You shouldn't check things in with warnings.

cgf
