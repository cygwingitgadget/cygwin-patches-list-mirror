Return-Path: <cygwin-patches-return-3583-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22271 invoked by alias); 18 Feb 2003 16:58:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22257 invoked from network); 18 Feb 2003 16:57:59 -0000
Date: Tue, 18 Feb 2003 16:58:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030218165804.GB7145@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030217185225.GD7514@redhat.com> <20030217201745.R97990-100000@logout.sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030217201745.R97990-100000@logout.sh.cvut.cz>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00232.txt.bz2

On Mon, Feb 17, 2003 at 08:23:21PM +0100, Vaclav Haisman wrote:
>> This is consistent with the way the rest of cygwin works, however.  The
>> same argument could be applied to testing for ntsec.  If this was an issue
>> then we should be changing the fs information to reflect reparse points.
>
>I am not sure what is the conclusion here. Should I make it check for
>FILE_SUPPORTS_SPARSE_FILES even though it can be inaccurate?

Yes.

cgf
