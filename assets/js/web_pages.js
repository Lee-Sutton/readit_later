import Vue from './init_vue';

const templateId = 'web-page-form';

if (document.getElementById(templateId)) {
    new Vue({
        el: `#${templateId}`,
        data: {
            tags: null,
        }
    });

}

