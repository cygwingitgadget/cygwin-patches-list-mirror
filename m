Return-Path: <cygwin-patches-return-2921-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27036 invoked by alias); 3 Sep 2002 12:28:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27022 invoked from network); 3 Sep 2002 12:28:44 -0000
Date: Tue, 03 Sep 2002 05:28:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
Message-ID: <20020903142809.B12899@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020830142028.F5475@cygbert.vinschen.de> <97179922214.20020830163339@logos-m.ru> <20020830150147.G5475@cygbert.vinschen.de> <110182341242.20020830171358@logos-m.ru> <s1selceuumv.fsf@jaist.ac.jp> <3D720D1F.37080487@yahoo.com> <s1sbs7hvijp.fsf@jaist.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s1sbs7hvijp.fsf@jaist.ac.jp>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00369.txt.bz2

On Mon, Sep 02, 2002 at 12:25:14AM +0900, Kazuhiro Fujieda wrote:
> >>> On Sun, 01 Sep 2002 08:50:39 -0400
> >>> Earnie Boyd <earnie_boyd@yahoo.com> said:
> 
> > So, instead of Corinna fixing the cygwin.din to/not to export them,
> > could you submit the patch?
> 
> Here it is.

> 2002-09-02  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
> 
> 	* cygwin.din: Revert exporting new wchar functions.
> 	* include/cygwin/version.h: Revert bumping API minor number.

Applied with a little tweak in version.h.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
