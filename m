Return-Path: <cygwin-patches-return-7863-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14185 invoked by alias); 2 Apr 2013 09:09:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 14077 invoked by uid 89); 2 Apr 2013 09:08:58 -0000
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.1
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Tue, 02 Apr 2013 09:08:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B03855201EA; Tue,  2 Apr 2013 11:08:52 +0200 (CEST)
Date: Tue, 02 Apr 2013 09:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Forgotted appersand
Message-ID: <20130402090852.GA12961@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CABEPuQL+SF_sV1NDYGHam8KWtgdzBKWqWDzUUgW9c4imQ1oriw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABEPuQL+SF_sV1NDYGHam8KWtgdzBKWqWDzUUgW9c4imQ1oriw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q2/txt/msg00001.txt.bz2

On Apr  2 12:46, ÐÐ»ÐµÐºÑÐµÐ¹ ÐÐ°Ð²Ð»Ð¾Ð² wrote:
> Hi!
> On cygwin-64bit-branch I think one appersand is forgotten.
> 
> --- a/winsup/cygwin/fhandler_disk_file.cc
> +++ b/winsup/cygwin/fhandler_disk_file.cc
> @@ -1176,7 +1176,7 @@ fhandler_disk_file::ftruncate (off_t length,
> bool allow_truncate)
>        /* Create sparse files only when called through ftruncate, not when
>  	 called through posix_fallocate. */
>        if (allow_truncate && pc.support_sparse ()
> -	  & !has_attribute (FILE_ATTRIBUTE_SPARSE_FILE)
> +	  && !has_attribute (FILE_ATTRIBUTE_SPARSE_FILE)
>  	  && length >= fsi.EndOfFile.QuadPart + (128 * 1024))
>  	{
>  	  status = NtFsControlFile (get_handle (), NULL, NULL, NULL, &io,

Thanks for catching!  I just applied the patch.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
