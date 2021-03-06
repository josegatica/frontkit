{% extends "main.swig" %}
{% set active = "docs" %}
{% import "../includes/macros.swig" as macros %}

{% block before_navbar %}
    <button class="btn btn-link navbar-btn pull-start show-small-below"
            ng-click="$event.stopPropagation(); showOffcanvas = !showOffcanvas">
        <span class="icon icon-menu"></span>
    </button>
{% endblock %}

{% block page %}
    <header class="hero-unit docs-master-head">
        <div class="container">
            <div class="row">
                <div class="column">
                    <h1>{{ pkg.title }}</h1>
                    <p>{{ pkg.description }}</p>
                </div>
            </div>
        </div>
    </header>

    <main class="container">
        <div class="row">
            <aside class="column medium-4-12 large-3-12 docs-sidebar"
                   offcanvas="showOffcanvas" target-screen="small-below">
                {% for menuId, data in menu %}
                <ul class="nav nav-list">
                    <li class="nav-header">{{ data.label }}</li>

                    {% for id, item in data.items -%}
                    <li class="nav-item {{ macros.docsClass( id ) }}">
                        {% if item.path %}
                        <a href="{{ macros.siteUrl( "docs/" + item.path ) }}">
                        {% else %}
                        <a href="{{ macros.siteUrl( "docs/" + menuId + "/" + id ) }}">
                        {% endif %}

                        {% if item.label -%}
                            {{ item.label }}
                        {% else %}
                            {{ item }}
                        {% endif %}

                        {% if item.js %}
                            <span class="label label-default js-highlight">JS</span>
                        {% endif %}
                        </a>

                        {% if docs === id %}
                            <div submenu></div>
                        {% endif %}
                    </li>
                    {%- endfor %}
                </ul>
                {% endfor %}
            </aside>

            <div class="column medium-8-12 large-9-12">
                <article class="docs-content">
                    {% block content %}{% endblock %}
                </article>
            </div>
        </div>
    </main>

    <footer class="docs-footer">
        <div class="container text-center">
            <ul class="list-inline">
                <li>{{ macros.socialButton( "github-stars" ) }}</li>
                <li>{{ macros.socialButton( "github-forks" ) }}</li>
                <li>{{ macros.socialButton( "twitter-tweet" ) }}</li>
                <li>{{ macros.socialButton( "twitter-follow" ) }}</li>
            </ul>

            <p>
                Frontkit is developed by the
                <a href="https://github.com/orgs/injoin/people">InJoin core team</a> and
                licensed under <a href="http://opensource.org/licenses/MIT">MIT</a>.
            </p>
        </div>
    </footer>
{% endblock %}