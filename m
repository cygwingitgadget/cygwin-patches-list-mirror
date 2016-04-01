Return-Path: <cygwin-patches-return-8537-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109474 invoked by alias); 1 Apr 2016 15:12:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109460 invoked by uid 89); 1 Apr 2016 15:12:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mail-oi0-f43.google.com
Received: from mail-oi0-f43.google.com (HELO mail-oi0-f43.google.com) (209.85.218.43) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Fri, 01 Apr 2016 15:12:36 +0000
Received: by mail-oi0-f43.google.com with SMTP id p188so76463255oih.2        for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2016 08:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=zlZb0WPOrE6lUsZ0hahEBGsqZinAJrQgPrgd5QxUYRQ=;        b=ZpvSA8L9/yGIsLNqFrlhbG7DIQQOu/1rOIDoLRiaLVddX1qAqsVb17E4jv0fd+kDzi         V3IIO8MirbPvI3tiCrZejemczxLExqzj0/ydLtMZo0elcFtLMldcrYOgmc7/GweS8oZZ         DTkDPimtMpLSWDhXUkzpgN4fPmOd1tn3EqBBBcwg42BicCXyj0Us4l2dj+MD7dTRmfKP         DQSgNIgrt+zpD0ulL3I1TjQ14zAFhGeBOSBULoQNlcc4Obz3rxHS+HXM9GdNVD3pXlY7         5ra2VtoTBCUpGyt0wiYyVg0w4l1MtUxqHsgarICvEjhKX7RPwLN/qKE+SPsvTFcz/L+Y         21fg==
X-Gm-Message-State: AD7BkJJJlRTjLDZgPMB7JOpVehoh10uVFWGi+muIkrUlWRSLScB3PThi5weWb6lR2T7IKrYe3Ume/gNhJ3sc7w==
X-Received: by 10.157.13.20 with SMTP id 20mr3277637oti.35.1459523553867; Fri, 01 Apr 2016 08:12:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.157.136 with HTTP; Fri, 1 Apr 2016 08:12:14 -0700 (PDT)
In-Reply-To: <20160401151040.GG16660@calimero.vinschen.de>
References: <1459441102-19941-1-git-send-email-pefoley2@pefoley.com> <20160401121318.GA16660@calimero.vinschen.de> <56FE73D7.8030306@cygwin.com> <CAOFdcFN0+eH76u6A0Z=gsyE8iEtzQFUTjyheQYzRk5Hfst_s=Q@mail.gmail.com> <20160401151040.GG16660@calimero.vinschen.de>
From: Peter Foley <pefoley2@pefoley.com>
Date: Fri, 01 Apr 2016 15:12:00 -0000
Message-ID: <CAOFdcFMh+PF+mO64TO4=sABsO=uhStqJ=MhkjsktmNEoyGbaqw@mail.gmail.com>
Subject: Re: [PATCH v2] Refactor to avoid nonnull checks on "this" pointer.
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00012.txt.bz2

On Fri, Apr 1, 2016 at 11:10 AM, Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
> As I mentioned in my first reply, I'd prefer if the callers check the
> pointer explicitly.  Changing the methods to static methods seems ...
> wrong.  Ugly, if you don't mind me saying so.

Fair enough, I'll respin this at some point.
