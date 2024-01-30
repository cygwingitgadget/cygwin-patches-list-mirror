Return-Path: <SRS0=ggc/=JI=gmail.com=angelasmith45367gm@sourceware.org>
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by sourceware.org (Postfix) with ESMTPS id 2304A3858034
	for <cygwin-patches@cygwin.com>; Tue, 30 Jan 2024 15:08:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2304A3858034
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2304A3858034
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::62a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706627286; cv=none;
	b=ufKBkSDXP/xgzqfmRIWJ9HUmWGSVRwZcBi4Pos+BcxPNmPIKZsVy+gmomzNgnAKVDhL9lZ/V3Jz/8zygc6/6bOnH1AzO0vNNw4WYVdOuxqT1Bvv1uqoQIRY1W6NSBhsbfCAvkkbZ0ixo4+nX3rrCb4kKlg2beHrD+vsoEbf7LL4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706627286; c=relaxed/simple;
	bh=4yBB9LBLfqIXhXg3cvoA/H6mEvaaQBhdvI+tHN7OhqM=;
	h=DKIM-Signature:From:Message-ID:To:Subject:Date:MIME-Version; b=Aml61wiKda5F16gtW4SXhQhrqnl8YP8Mud4xldsqE28X60cNXxgNd1FcXojNWw3ws3Ms4ei1qGTQ8JYoZdegxDbE/K/JhMQYDjMd1XbkqGx/oVvb7geayp507SgVO0DBZs1EHGJMX6x2yWLWDYLGfx12AThAk5uvKx522rquVGU=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a34c5ca2537so449914566b.0
        for <cygwin-patches@cygwin.com>; Tue, 30 Jan 2024 07:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706627278; x=1707232078; darn=cygwin.com;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6bY2F++0NMYSBCxw1oWjV0nUhCdU6DWdKYzrYcyk0Q=;
        b=ndK09SkwyKvbbNPqkAU8phSSjkqWJTIzjV9wh6T+ZTqFMfU8TZTTEzWdGp3PVRxF6K
         5U9/HbNSPqQhORhjIHUfMMkBoE1+2a7OIdiJ/X/+IOSSiu3QQscijDvrYAfWChYNP7mM
         Jxd0BYj8UIIRc1qpwz11zDdGo7wKW+K2arIjLylSim7srrctRJhgXf+4CRZwE74BLQGb
         tvL0LN/3MTVWiBjFYyNXu1Zn+HjL++bfagkrVKzCOczu+hLskOUOgv/SMqsgrEYqcuWf
         WzeLjjwSA7OGBxmTfyH93/J/wKe2chL5hujz26lv1uTupxitBAW01voGDOh0GiLjCYVS
         Jeiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706627278; x=1707232078;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6bY2F++0NMYSBCxw1oWjV0nUhCdU6DWdKYzrYcyk0Q=;
        b=RBzO7n9mwNNrZXYN2Bd2fDP7HizrPcN+rTKpWUB1zSHbEwArKNjuFsEJFo5vyg2706
         FzOnFkxDH2hhHE0aSwY3hWHZQo9VR2vEKWQ6+wRCkGJml9eyqNwr5LA1XuIdB9bpzRJ0
         YYGs9bgmvPvZ4HtRpjD3pZIR+A1RP+9pOK1WjMb05RBSMJQx0ZnVKWy7GsImrx0+ErsQ
         kc+Uq8YdXDmB/TQhE4Q2jErXzNLf7ISALim0f1bt9Mnpl8ZPXgQzJ65tU2Kz5BlA0XOy
         uZmlStbuvAnKyQyvjyMW4cusvz9dXxihl5klzWUfPVwtswUcUcpbAExnJeb+ob9ewMyO
         YX4w==
X-Gm-Message-State: AOJu0YxDkNwSQCBDV6K53O/eQU8aIq5LHUzVbHLBVbEME3YNs0uOVNgR
	a+/gnZtoBrFKd13s8n3yePsZYePyuG6oo9mdLv309Hl0sWP8itCWdigyql0jWLQ=
X-Google-Smtp-Source: AGHT+IF1crOUusc4GT0AmEQgA/NMzOUe8qO+S5TSeiiwX7awsl6GUm8Cwv6EtihCSaUaLAIbpxpbHA==
X-Received: by 2002:a17:906:f281:b0:a26:c376:d1dc with SMTP id gu1-20020a170906f28100b00a26c376d1dcmr6117408ejb.70.1706627278436;
        Tue, 30 Jan 2024 07:07:58 -0800 (PST)
Received: from [185.222.58.71] ([185.222.58.71])
        by smtp.gmail.com with ESMTPSA id tz15-20020a170907c78f00b00a356e5ac7casm3418022ejc.86.2024.01.30.07.07.58
        for <cygwin-patches@cygwin.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jan 2024 07:07:58 -0800 (PST)
From: Ruth Lennon <angelasmith45367gm@gmail.com>
X-Google-Original-From: Ruth Lennon <ruthlennon1957@hotmail.com>
Message-ID: <af83714eb58b09c079894c14c2503893aebab7e04f017b54208afd1d07e2ec7e@mx.google.com>
Reply-To: ruthlennon1957@hotmail.com
To: cygwin-patches@cygwin.com
Subject: Giving Out Yamaha Baby Grand.
Date: Tue, 30 Jan 2024 16:07:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

I am giving away my late husband's Yamaha Grand Baby GC1 to a passionate instrument lover. If you know of a fellow teacher, school, student, family or church that might be interested, please forward this email to them.God bless you.Ruth.
 
