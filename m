Return-Path: <cygwin-patches-return-1994-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16603 invoked by alias); 19 Mar 2002 15:48:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16527 invoked from network); 19 Mar 2002 15:48:48 -0000
Date: Tue, 19 Mar 2002 09:13:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: new mkgroup patch
Message-ID: <20020319154842.GG949@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020317054400.4671.qmail@web20008.mail.yahoo.com> <20020319162828.X29574@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020319162828.X29574@cygbert.vinschen.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00351.txt.bz2

On Tue, Mar 19, 2002 at 04:28:28PM +0100, Corinna Vinschen wrote:
>On Sat, Mar 16, 2002 at 09:44:00PM -0800, Joshua Daniel Franklin wrote:
>> Here is a new patch that retains the multiple fprintf's instead of 
>> using a multiline one in the usage function. Also adds version option, etc.:
>
>Thanks for the patch.  Applied.

After talking about this with Corinna, I have modified the usage
function to use one fprintf and string concatenation to accomplish what
Joshua was trying to do with one string and embedded newlines and line
continuations.  This maintains the same indentation as the previous
version and doesn't jam everything against column one.

cgf
