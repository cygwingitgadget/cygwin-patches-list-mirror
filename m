Return-Path: <marco.atzeri@gmail.com>
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by sourceware.org (Postfix) with ESMTPS id E70583858415
 for <cygwin-patches@cygwin.com>; Sat,  5 Feb 2022 17:50:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E70583858415
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-x534.google.com with SMTP id b13so20425979edn.0
 for <cygwin-patches@cygwin.com>; Sat, 05 Feb 2022 09:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=8R58EIsbN+5m+DA+XrmCRkT0MG7iYtKGiifB+7WDfO4=;
 b=ExRUqyTktrHO/taeXsQJOY8qbiNi89Pim8ZxCbSwNbqQs2Ix/rpkMZuDnInYVGHvdn
 bM/Dg0d8NzF7klXSdcn97ogz3DsAuYd1KlsFZUIXysbjpXTfRBnfU0gNUft979HRJ4sT
 GBmwztH0MPGPzMAWeQVPI6V8ks8VXUgBF9xMR4B2wjyGqKL5Xva9iqaFPbvrsL/CdQuG
 2MzsIcj3DPjo5aA7mSOqh+Ucoe6t0SeJYWy864AsdpTJpEIuPR+wj66BicLOBHhpwfin
 AGelVTpkPhYN1btOOdjJNvQuuKRw7Evkq40hW7TC7nserGBzlVbjkN+FnV/LJutdl9NV
 J0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8R58EIsbN+5m+DA+XrmCRkT0MG7iYtKGiifB+7WDfO4=;
 b=R+VDQL2Ix8ACXz1tVKZsb2UzdRO+v+Vxo7A6zIPOpXCwjvgX8fxTtiFNOLTkpEhvsw
 6QGQQTI2OxHWFWxHlvY1zqhV8H7VhcsxiqgNyN2ghga7pca6bNp3DXpTaos03eUElJvp
 j0EurYlMqxmzkxSZ1saF/dZQpBIwcdYNKXbExfAVDAl22gVDk07tOPDC28APtc286usn
 vnxEt7ShRcg/t+QPIUAemC5WFiMK/fKtds0hgE5FV5aFXRNVvme0qP7Pfokz0SkQSlrG
 iwcmXW+JMDyqtqhe+yP+nnwKVIebPvnNr0WUpMINPcdu0dDSa5F5IcfG2OzYt0L6yBLn
 BHBQ==
X-Gm-Message-State: AOAM530rtUSVVi+8RoioEWORONmSsaOMuRT+ByLinPjsgdKXF/8pynP6
 hfNLJRvBNvOxv5DJ2G1C361zu2EJmRI=
X-Google-Smtp-Source: ABdhPJzZ2Wx88XqtcvavYPIllOAR/KxkK2dZaGZg8AWrAUeqc/ParuM4l7TfOrskdJBZdMdgeulsbg==
X-Received: by 2002:a05:6402:1c1e:: with SMTP id
 ck30mr5394875edb.266.1644083442027; 
 Sat, 05 Feb 2022 09:50:42 -0800 (PST)
Received: from ?IPV6:2003:cc:9f05:ad1a:f18d:60d0:9a8f:38b8?
 (p200300cc9f05ad1af18d60d09a8f38b8.dip0.t-ipconnect.de.
 [2003:cc:9f05:ad1a:f18d:60d0:9a8f:38b8])
 by smtp.gmail.com with ESMTPSA id bh3sm1306096ejb.102.2022.02.05.09.50.41
 for <cygwin-patches@cygwin.com>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Feb 2022 09:50:41 -0800 (PST)
Message-ID: <3f2dd608-351b-c105-7191-e1992f034c9e@gmail.com>
Date: Sat, 5 Feb 2022 18:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] update site goldstar award types images from jpg/png to
 webp
Content-Language: it
To: cygwin-patches@cygwin.com
References: <20220202065958.6840-1-Brian.Inglis@SystematicSW.ab.ca>
 <YfpSaFiy7EH6BwAy@calimero.vinschen.de>
 <5d10614e-adbc-38e4-2b69-f5794d1e24c9@SystematicSw.ab.ca>
 <Yfrskl5AsCMMepFc@calimero.vinschen.de>
 <dc63c4eb-489d-be97-8f54-3aedc7645ebf@dronecode.org.uk>
From: Marco Atzeri <marco.atzeri@gmail.com>
In-Reply-To: <dc63c4eb-489d-be97-8f54-3aedc7645ebf@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_FROM, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP, T_SCC_BODY_TEXT_LINE,
 WINNER_SUBJECT autolearn=no autolearn_force=no version=3.4.4
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 05 Feb 2022 17:50:44 -0000

On 05.02.2022 15:26, Jon Turney wrote:
> On 02/02/2022 20:41, Corinna Vinschen wrote:
>> On Feb  2 11:49, Brian Inglis wrote:
>>> On 2022-02-02 02:44, Corinna Vinschen wrote:
>>>> On Feb  1 23:59, Brian Inglis wrote:
> [...]
>>>
>>> Would you be interested in a similar patch series for the whole site?
> 
> Do you have any information on how widespread browser support for webp is?

https://caniuse.com/webp
It seems covered by most of recent browsers

